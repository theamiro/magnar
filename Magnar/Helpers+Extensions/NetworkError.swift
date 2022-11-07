//
//  NetworkError.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

enum NetworkError: Error {
    case custom(String)
    case errorFetchingData
    case invalidURL
    case invalidResponseStatusCode
    case emptyData
    case responseNotDecodable
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .custom(let message):
            return NSLocalizedString("\(message)", comment: message)
        case .errorFetchingData, .invalidURL:
            return NSLocalizedString("An error occurred while attempting to fetch data. Please try again later.", comment: "Network Error")
        case .invalidResponseStatusCode:
            return NSLocalizedString("We cannot access the data service provider.", comment: "Network Error")
        case .emptyData, .responseNotDecodable:
            return NSLocalizedString("We received an unexpected response from the server and thus cannot display it.", comment: "Network Error")
        }
    }
}
