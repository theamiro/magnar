//
//  RequestHandler.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

protocol RequestHandlerDelegate {
    func fetch(url: String, completion: @escaping(Result<Data, NetworkError>) -> Void)
    func fetch(resource: String, `extension`: String, completion: @escaping(Result<Data, NetworkError>) -> Void)
}

class RequestHandler: RequestHandlerDelegate {
    func fetch(url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.errorFetchingData))
                return
            }
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                completion(.failure(.invalidResponseStatusCode))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    func fetch(resource: String, `extension`: String, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: `extension`) else {
            completion(.failure(.custom("Error fetching resource from URL.")))
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(.custom("Error reading contents of file.")))
            return
        }
        completion(.success(data))
    }
}

extension Data {
    var prettyPrint: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
