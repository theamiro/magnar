//
//  MainCoordinatorTests.swift
//  MagnarTests
//
//  Created by Michael Amiro on 07/11/2022.
//

import XCTest
@testable import Magnar

class MainCoordinatorMock: MainCoordinator {
    var goToHousesViewCalled = false
    var goToCharactersViewCalled = false
    var goToBooksViewCalled = false
    var didShowViewControllerCalled = false

    override func goToHousesView() {
        goToHousesViewCalled = true
        super.goToHousesView()
    }

    override func goToCharactersView() {
        goToCharactersViewCalled = true
        super.goToCharactersView()
    }

    override func goToBooksView() {
        goToBooksViewCalled = true
        super.goToBooksView()
    }

    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        didShowViewControllerCalled = true
        super.navigationController(navigationController, didShow: viewController, animated: animated)
    }
}

final class MainCoordinatorTests: XCTestCase {
    var sut: MainCoordinatorMock!
    let testViewController = CharacterViewController()

    override func setUpWithError() throws {
        let navigationController = UINavigationController()
        sut = MainCoordinatorMock(navigationController: navigationController)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(sut.childCoordinators.count, 0, "Child coordinator already exists before any push actions.")
    }

    func testGoToHousesView() {
        sut.goToHousesView()
        XCTAssertTrue(sut.goToHousesViewCalled)

        XCTAssert(sut.childCoordinators.count > 0)
    }

    func testGoToCharactersView() {
        sut.goToCharactersView()
        XCTAssertTrue(sut.goToCharactersViewCalled)

        XCTAssert(sut.childCoordinators.count > 0)
    }

    func testGoToBooksView() {
        sut.goToBooksView()
        XCTAssertTrue(sut.goToBooksViewCalled)

        XCTAssert(sut.childCoordinators.count > 0)
    }
}
