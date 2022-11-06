//
//  CharactersViewModelTests.swift
//  MagnarTests
//
//  Created by Michael Amiro on 06/11/2022.
//

import XCTest
@testable import Magnar

class CharactersViewModelMock: CharacterViewModel {
    var isGoToCharacterDetailViewCalled = false
    var isOnRowSelectedCalled = false

    override func onRowSelected(indexPath: IndexPath) {
        isOnRowSelectedCalled = true
        super.onRowSelected(indexPath: indexPath)
    }
}

final class CharactersViewModelTests: XCTestCase {
    var sut: CharactersViewModelMock!

    var networkService = NetworkService()

    lazy var characterService: GOTCharacterService = {
        let characterService = GOTCharacterService(networkService: networkService)
        return characterService
    }()

    override func setUpWithError() throws {
        sut = CharactersViewModelMock(characterService: characterService)
        sut.goToCharacterDetailView = { [weak self] _ in
            self?.sut.isGoToCharacterDetailViewCalled = true
        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInitialStateWithMockData() {
        
    }

//    func testGoToCharacterDetailsView() {
//        sut.onRowSelected(indexPath: IndexPath(row: 0, section: 0))
//
//        XCTAssertTrue(sut.isOnRowSelectedCalled, "onRowSelected is not called")
//
//        XCTAssertTrue(sut.isGoToCharacterDetailViewCalled, "isGoToCharacterDetailViewCalled is not called")
//    }
}
