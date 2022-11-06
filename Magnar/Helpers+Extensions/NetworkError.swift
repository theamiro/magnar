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
