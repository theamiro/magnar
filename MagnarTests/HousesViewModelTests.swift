//
//  HousesViewModelTests.swift
//  MagnarTests
//
//  Created by Michael Amiro on 07/11/2022.
//

import XCTest
@testable import Magnar

class HousesViewModelMock: HouseViewModel {
    var isGoToHouseDetailViewCalled = false
    var isOnRowSelectedCalled = false
    var isModelDidUpdateCalled = false

    override func onRowSelected(indexPath: IndexPath) {
        isOnRowSelectedCalled = true
        super.onRowSelected(indexPath: indexPath)
    }
}

final class HousesViewModelTests: XCTestCase {
    var sut: HousesViewModelMock!
    var networkService = NetworkService(shouldMock: true)

    lazy var houseService: HouseService = {
        let service = HouseService(networkService: networkService)
        return service
    }()

    override func setUpWithError() throws {
        sut = HousesViewModelMock(houseService: houseService)
        sut.goToHouseDetailView = { [weak self] _ in
            self?.sut.isGoToHouseDetailViewCalled = true
        }
        sut.modelDidUpdate = { [weak self] in
            self?.sut.isModelDidUpdateCalled = true
        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(sut.sections.count, 1, "Houses section has not been initialized.")
        XCTAssertEqual(sut.sections[0].cells.count, 1, "Count of houses is higher than expected")
        let houseField = sut.sections.first?.cells.first as? HouseField
        XCTAssertNotNil(houseField, "Houses field is null")

        if let houseField {
            XCTAssertEqual(houseField.model.title, "House Targaryen of King's Landing", "House field Title is not correctly set up")
        }
    }

    func testGoToHouseDetailView() {
        sut.onRowSelected(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(sut.isOnRowSelectedCalled)
        XCTAssertTrue(sut.isGoToHouseDetailViewCalled)
    }
}
