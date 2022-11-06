//
//  BooksViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import Foundation

class BooksViewModel: TableBackedViewModel {
    private let bookService: BookServiceDelegate
    var goToBookDetailView: (Book) -> Void = { _ in }
    var state: State = State()

    init(bookService: BookServiceDelegate = BookService(networkService: NetworkService())) {
        self.bookService = bookService
        super.init()
        self.sections = [TableSection(id: 0, cells: [])]
        title = "Books"

        getBooks()
    }

    func getBooks() {
        bookService.getBooks { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let books):
                self?.state.books = books
                self?.makeBookCells()
            }
        }
    }

    func makeBookCells() {
        for index in state.books.indices {
            let model = SelectableCellWithLeftImageFieldModel(with: state.books[index])
            sections[0].cells.append(SelectableCellWithLeftImageField(tag: index, model: model))
        }
        modelDidUpdate()
    }

    func onRowSelected(indexPath: IndexPath) {
        let selectedCell = sections[indexPath.section].cells[indexPath.row].tag
        goToBookDetailView(state.books[selectedCell])
    }

    struct State {
        var books: [Book] = []
    }
}
