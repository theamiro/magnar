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

    var networkService = NetworkService(shouldMock: true)

    lazy var characterService: GOTCharacterService = {
        let characterService = GOTCharacterService(networkService: networkService)
        return characterService
    }()

    override func setUpWithError() throws {
        let characterService = GOTCharacterService(networkService: networkService)
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
        characterService.getCharacters { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let characters):
                print(characters)
            }
        }
    }

//    func testGoToCharacterDetailsView() {
//        sut.onRowSelected(indexPath: IndexPath(row: 0, section: 0))
//
//        XCTAssertTrue(sut.isOnRowSelectedCalled, "onRowSelected is not called")
//
//        XCTAssertTrue(sut.isGoToCharacterDetailViewCalled, "isGoToCharacterDetailViewCalled is not called")
//    }
}
