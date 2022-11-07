//
//  BookDetailsViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import Foundation

class BookDetailViewModel: TableBackedViewModel {

    var state: State
    init(book: Book) {
        self.state = State(book: book)
        super.init()
        title = book.name

        self.sections = [
            TableSection(id: Tag.Section.isbn, title: "ISBN", cells: []),
            TableSection(id: Tag.Section.publisher, title: "Publisher", cells: []),
            TableSection(id: Tag.Section.country, title: "Country", cells: []),
            TableSection(id: Tag.Section.mediaType, title: "Media Type", cells: []),
            TableSection(id: Tag.Section.authors, title: "Authors", cells: [])
        ]

        makeSimpleCell(using: state.book.isbn, at: Tag.Section.isbn)
        makeSimpleCell(using: state.book.publisher, at: Tag.Section.publisher)
        makeSimpleCell(using: state.book.country, at: Tag.Section.country)
        makeSimpleCell(using: state.book.mediaType, at: Tag.Section.mediaType)
        if state.book.authors.count > 0 {
            makeAuthorsSection()
        }
    }

    func makeSimpleCell(using text: String, at section: Int) {
        let model = SimpleTextFieldModel(text: text)
        self.sections[section].cells.append(SimpleTextField(tag: 0, model: model))
    }

    func makeAuthorsSection() {
        for authorIndex in state.book.authors.indices {
            let author = state.book.authors[authorIndex]
            let model = SimpleTextFieldModel(text: author)
            sections[Tag.Section.authors].cells.append(SimpleTextField(tag: authorIndex, model: model))
        }
    }

    struct State {
        var book: Book
    }

    enum Tag {
        enum Section {
            static let isbn = 0
            static let publisher = 1
            static let country = 2
            static let mediaType = 3
            static let authors = 4
        }
    }
}
