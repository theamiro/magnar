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
        sut = CharactersViewModelMock(characterService: characterService)
        sut.goToCharacterDetailView = { [weak self] _ in
            self?.sut.isGoToCharacterDetailViewCalled = true
        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(sut.sections.count, 1, "Characters section has not been initialized.")
        XCTAssertEqual(sut.sections[0].cells.count, 1, "Count of characters is higher/lower than expected")
        let characterField = sut.sections.first?.cells.first as? SelectableCellWithLeftImageField
        XCTAssertNotNil(characterField, "Characters field is null")

        if let characterField {
            XCTAssertEqual(characterField.model.title, "Jon Snow", "Character Field field Title is not correctly set up")
        }
    }

    func testGoToHouseDetailView() {
        sut.onRowSelected(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(sut.isOnRowSelectedCalled)
        XCTAssertTrue(sut.isGoToCharacterDetailViewCalled)
    }
}
