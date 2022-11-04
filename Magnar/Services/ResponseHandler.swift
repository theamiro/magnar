//
//  ResponseHandler.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

protocol ResponseHandlerDelegate {
    func decode<T: Decodable>(data: Data, type: T.Type, completion: @escaping(Result<T, NetworkError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func decode<T: Decodable>(data: Data, type: T.Type, completion: @escaping(Result<T, NetworkError>) -> Void) {
        let response = try? JSONDecoder().decode(T.self, from: data)
        guard let response = response else {
            completion(.failure(.responseNotDecodable))
            return
        }
        print("Response", response)
        completion(.success(response))
    }
}
