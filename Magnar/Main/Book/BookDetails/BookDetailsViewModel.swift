//
//  BookDetailsViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import Foundation

class BookDetailViewModel: TableViewModel {
    init(book: Book) {
        super.init()
        title = book.name
    }
}
