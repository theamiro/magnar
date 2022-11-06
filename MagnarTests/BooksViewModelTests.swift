//
//  BooksViewModelTests.swift
//  MagnarTests
//
//  Created by Michael Amiro on 07/11/2022.
//

import XCTest
@testable import Magnar

class BooksViewModelMock: BooksViewModel {
    var isGoToBookDetailViewCalled = false
    var isOnRowSelectedCalled = false

    override func onRowSelected(indexPath: IndexPath) {
        isOnRowSelectedCalled = true
        super.onRowSelected(indexPath: indexPath)
    }
}

final class BooksViewModelTests: XCTestCase {
    var sut: BooksViewModelMock!

    var networkService = NetworkService()

    lazy var bookService: BookService = {
        let service = BookService(networkService: networkService)
        return service
    }()

    override func setUpWithError() throws {
        sut = BooksViewModelMock(bookService: bookService)
        sut.goToBookDetailView = { [weak self] _ in
            self?.sut.isGoToBookDetailViewCalled = true
        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
