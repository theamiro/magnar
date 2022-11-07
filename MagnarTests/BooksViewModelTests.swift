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
    var isModelDidUpdateCalled = false

    override func onRowSelected(indexPath: IndexPath) {
        isOnRowSelectedCalled = true
        super.onRowSelected(indexPath: indexPath)
    }
}

final class BooksViewModelTests: XCTestCase {
    var sut: BooksViewModelMock!

    var networkService = NetworkService(shouldMock: true)

    lazy var bookService: BookServiceDelegate = {
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

    func testInitialState() {
        XCTAssertEqual(sut.sections.count, 1, "Books section has not been initialized.")
        XCTAssertEqual(sut.sections[0].cells.count, 1, "Count of books is higher than expected")
        let bookField = sut.sections.first?.cells.first as? SelectableCellWithLeftImageField
        XCTAssertNotNil(bookField, "Book field is null")

        if let bookField {
            XCTAssertEqual(bookField.model.title, "A Game of Thrones", "Book field Title is not correctly set up")
        }
    }

    func testGoToBookDetailView() {
        sut.onRowSelected(indexPath: IndexPath(row: 0, section: 0))

        XCTAssertTrue(sut.isOnRowSelectedCalled)
        XCTAssertTrue(sut.isGoToBookDetailViewCalled)
    }
}
