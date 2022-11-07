//
//  NetworkService.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

protocol NetworkServiceDelegate {
    var shouldMock: Bool { get set }
    func fetch<T: Decodable>(url: String, type: T.Type, completion: @escaping(Result<T,NetworkError>) -> Void)
    func fetch<T: Decodable>(resource: String, type: T.Type, completion: @escaping(Result<T,NetworkError>) -> Void)
}

class NetworkService: NetworkServiceDelegate {
    var shouldMock: Bool
    var requestHandler: RequestHandlerDelegate
    var responseHandler: ResponseHandlerDelegate

    init(requestHandler: RequestHandlerDelegate = RequestHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler(),
         shouldMock: Bool = false) {
        self.requestHandler = requestHandler
        self.responseHandler = responseHandler
        self.shouldMock = shouldMock
    }

    func fetch<T: Decodable>(url: String, type: T.Type, completion: @escaping(Result<T,NetworkError>) -> Void) {
        requestHandler.fetch(url: url) { [weak self] result in
            switch result {
            case .failure(let error):
                    completion(.failure(error))
            case .success(let data):
                self?.responseHandler.decode(data: data, type: type) { result in
                    switch result {
                    case .failure(let error):
                            completion(.failure(error))
                    case .success(let model):
                        completion(.success(model))
                    }
                }
            }
        }
    }

    func fetch<T: Decodable>(resource: String, type: T.Type, completion: @escaping(Result<T,NetworkError>) -> Void) {
        requestHandler.fetch(resource: resource, extension: "json") { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                self?.responseHandler.decode(data: data, type: type) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let model):
                        completion(.success(model))
                    }
                }
            }
        }
    }
}
