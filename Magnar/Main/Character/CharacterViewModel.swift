//
//  CharacterViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import Foundation

class CharacterViewModel: TableBackedViewModel {
    private let characterService: GOTCharacterServiceDelegate
    var goToCharacterDetailView: (GOTCharacter) -> Void = { _ in }
    var state: State = State()

    init(characterService: GOTCharacterServiceDelegate = GOTCharacterService(networkService: NetworkService())) {
        self.characterService = characterService
        super.init()
        self.sections = [TableSection(id: 0, cells: [])]
        title = "Characters"

        getCharacters()
    }

    func getCharacters() {
        characterService.getCharacters { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let characters):
                self?.state.characters = characters
                self?.makeCharacterCells()
            }
        }
    }

    private func makeCharacterCells() {
        for index in state.characters.indices {
            let model = SelectableCellWithLeftImageFieldModel(with: state.characters[index])
            sections[0].cells.append(SelectableCellWithLeftImageField(tag: index, model: model))
        }
    }

    func onRowSelected(indexPath: IndexPath) {
        let selectedCellTag = sections[indexPath.section].cells[indexPath.row].tag
        goToCharacterDetailView(state.characters[selectedCellTag])
    }

    struct State {
        var characters: [GOTCharacter] = []
        var page: Int = 1
    }
}

