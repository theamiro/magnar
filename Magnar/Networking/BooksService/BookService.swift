//
//  BookService.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import Foundation

protocol BookServiceDelegate {
    func getBooks(completion: @escaping(Result<[Book], NetworkError>) -> Void)
    func getBookByURL(url: String, completion: @escaping(Result<Book, NetworkError>) -> Void)
}

class BookService: BookServiceDelegate {
    var networkService: NetworkServiceDelegate

    init(networkService: NetworkServiceDelegate = NetworkService()) {
        self.networkService = networkService
    }

    func getBooks(completion: @escaping (Result<[Book], NetworkError>) -> Void) {
        if networkService.shouldMock {
            networkService.fetch(resource: "books", type: [Book].self, completion: completion)
        } else {
            networkService.fetch(url: "https://anapioficeandfire.com/api/books", type: [Book].self, completion: completion)
        }
    }

    func getBookByURL(url: String, completion: @escaping (Result<Book, NetworkError>) -> Void) {
        if networkService.shouldMock {
            networkService.fetch(resource: "book", type: Book.self, completion: completion)
        } else {
            networkService.fetch(url: url, type: Book.self, completion: completion)
        }
    }
}
