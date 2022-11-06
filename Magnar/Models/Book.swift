//
//  Book.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import Foundation

struct Book: Decodable {
    let url, name, isbn, publisher, country, mediaType: String
    let authors: [String]
    let numberOfPages: Int
}

