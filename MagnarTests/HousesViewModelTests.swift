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

    override func onRowSelected(indexPath: IndexPath) {
        isOnRowSelectedCalled = true
        super.onRowSelected(indexPath: indexPath)
    }
}

final class HousesViewModelTests: XCTestCase {
    var sut: HousesViewModelMock!
    var networkService = NetworkService()

    lazy var houseService: HouseService = {
        let service = HouseService(networkService: networkService)
        return service
    }()

    override func setUpWithError() throws {
        sut = HousesViewModelMock(houseService: houseService)
        sut.goToHouseDetailView = { [weak self] _ in
            self?.sut.isGoToHouseDetailViewCalled = true
        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
