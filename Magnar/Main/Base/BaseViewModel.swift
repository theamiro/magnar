//
//  BaseViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

class BaseViewModel: TableViewModel {
    var goToHousesView: () -> Void = { }
    var goToCharactersView: () -> Void = { }
    var goToBooksView: () -> Void = { }

    lazy var houses: SimpleTextField = {
        let model = SimpleTextFieldModel(text: "GOT Houses")
        return SimpleTextField(tag: Tag.Cell.houses, model: model)
    }()
    lazy var characters: SimpleTextField = {
        let model = SimpleTextFieldModel(text: "GOT Characters")
        return SimpleTextField(tag: Tag.Cell.characters, model: model)
    }()
    lazy var books: SimpleTextField = {
        let model = SimpleTextFieldModel(text: "GOT Books")
        return SimpleTextField(tag: Tag.Cell.books, model: model)
    }()

    override init() {
        super.init()
        self.sections = [TableSection(id: 0, cells: [houses, characters, books])]
        self.title = "Home"
    }

    func onRowSelected(indexPath: IndexPath) {
        let selectedCell = sections[indexPath.section].cells[indexPath.row].tag
        switch selectedCell {
        case Tag.Cell.houses:
            goToHousesView()
        case Tag.Cell.characters:
            goToCharactersView()
        case Tag.Cell.books:
            goToBooksView()
        default:
            return
        }
    }

    enum Tag {
        enum Cell {
            static let houses = 0
            static let characters = 1
            static let books = 2
        }
    }
}
