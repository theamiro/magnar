//
//  HomeViewModelTests.swift
//  MagnarTests
//
//  Created by Michael Amiro on 06/11/2022.
//

import XCTest
@testable import Magnar

class BaseViewModelMock: HomeViewModel {
    var isGoToHousesViewCalled = false
    var isGoToCharacterViewCalled = false
    var isGoToBooksViewCalled = false

    var isOnRowSelectedCalled = false

    override func onRowSelected(indexPath: IndexPath) {
        isOnRowSelectedCalled = true
        super.onRowSelected(indexPath: indexPath)
    }
}

final class HomeViewModelTests: XCTestCase {
    var sut: BaseViewModelMock!

    override func setUpWithError() throws {
        sut = BaseViewModelMock()
        sut.goToHousesView = { [weak self] in
            self?.sut.isGoToHousesViewCalled = true
        }
        sut.goToCharactersView = { [weak self] in
            self?.sut.isGoToCharacterViewCalled = true
        }
        sut.goToBooksView = { [weak self] in
            self?.sut.isGoToBooksViewCalled = true
        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testHomeViewInitialState() {
        let tableSectionAdded = sut.sections.contains(where: {$0.id == 0})
        XCTAssertTrue(tableSectionAdded, "Table section is not added and invisible.")

        XCTAssertEqual(sut.sections.count, 1, "Invalid number of sections.")
        XCTAssertEqual(sut.sections[0].cells.count, 3, "Invalid number of rows in section 1")

        let housesField = sut.sections[0].cells.first as? BaseField
        XCTAssertNotNil(housesField, "Houses field does not exist or is mismatched to BaseField type")
        XCTAssertEqual(housesField?.model.title, "Houses", "Static text does not match.")
    }

    func testGoToHousesViewCalled() {
        sut.onRowSelected(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(sut.isOnRowSelectedCalled, "onRowSelected is not called")

        XCTAssertTrue(sut.isGoToHousesViewCalled, "isGoTOHousesView is not called")
    }

    func testGoToCharactersViewCalled() {
        sut.onRowSelected(indexPath: IndexPath(row: 1, section: 0))

        XCTAssertTrue(sut.isOnRowSelectedCalled, "onRowSelected is not called")

        XCTAssertTrue(sut.isGoToCharacterViewCalled, "isGoToCharacterView is not called")
    }

    func testGoToBooksViewCalled() {
        sut.onRowSelected(indexPath: IndexPath(row: 2, section: 0))

        XCTAssertTrue(sut.isOnRowSelectedCalled, "onRowSelected is not called")

        XCTAssertTrue(sut.isGoToBooksViewCalled, "isGoToBooksView is not called")
    }
}
