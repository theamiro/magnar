//
//  CharacterDetailsViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import Foundation

class CharacterDetailsViewModel: TableBackedViewModel {
    var state: State
    private let houseService: HouseServiceDelegate
    private let bookService: BookServiceDelegate
    init(houseService: HouseServiceDelegate = HouseService(networkService: NetworkService()),
         bookService: BookServiceDelegate = BookService(networkService: NetworkService()),
         character: GOTCharacter) {
        self.state = State(character: character)
        self.houseService = houseService
        self.bookService = bookService
        super.init()
        self.title = state.character.name == "" ? state.character.aliases.first ?? "No Name" : state.character.name
        
        sections.append(makeGenderSection())
        sections.append(makeTitlesSection())
        sections.append(makeAliasesSection())
        if state.character.allegiances.count > 0 {
            sections.append(makeAllegiancesSection())
        }
        sections.append(makeBooksSection())
        if state.character.povBooks.count > 0 {
            sections.append(makePOVBooksSection())
        }
        sections.append(makeTVSeriesSection())
    }

    func makeGenderSection() -> TableSection {
        let model = SimpleTextFieldModel(text: state.character.gender)
        return TableSection(id: Tag.Section.gender, title: "Gender", cells: [SimpleTextField(tag: 0, model: model)])
    }

    func makeTitlesSection() -> TableSection {
        let cells = state.character.titles.enumerated().map { item -> SimpleTextField in
            let index = item.offset
            let title = item.element
            let model = SimpleTextFieldModel(text: title == "" ? "None" : title)
            return SimpleTextField(tag: index, model: model)
        }
        return TableSection(id: Tag.Section.titles, title: "Titles", cells: cells)
    }

    func makeAliasesSection() -> TableSection {
        let cells = state.character.aliases.enumerated().map { item -> SimpleTextField in
            let index = item.offset
            let alias = item.element
            let model = SimpleTextFieldModel(text: alias)
            return SimpleTextField(tag: index, model: model)
        }
        return TableSection(id: Tag.Section.aliases, title: "Aliases", cells: cells)
    }

    func makeAllegiancesSection() -> TableSection {
        let cells = state.character.allegiances.enumerated().map { item -> SimpleTextField in
            let index = item.offset
            let allegiance = item.element
            let model = SimpleTextFieldModel(text: allegiance)
            return SimpleTextField(tag: index, model: model)
        }
        return TableSection(id: Tag.Section.allegiances, title: "Allegiances", cells: cells)
    }

    func makeBooksSection() -> TableSection {
        let cells = state.character.books.enumerated().map { item -> SimpleTextField in
            let index = item.offset
            let book = item.element
            let model = SimpleTextFieldModel(text: book)
            return SimpleTextField(tag: index, model: model)
        }
        return TableSection(id: Tag.Section.books, title: "Books", cells: cells)
    }

    func makePOVBooksSection() -> TableSection {
        let cells = state.character.povBooks.enumerated().map { item -> SimpleTextField in
            let index = item.offset
            let book = item.element
            let model = SimpleTextFieldModel(text: book)
            return SimpleTextField(tag: index, model: model)
        }
        return TableSection(id: Tag.Section.povBooks, title: "POV Books", cells: cells)
    }

    func makeTVSeriesSection() -> TableSection {
        let cells = state.character.tvSeries.enumerated().map { item -> SimpleTextField in
            let index = item.offset
            let series = item.element
            let model = SimpleTextFieldModel(text: series == "" ? "No Series Title" : series)
            return SimpleTextField(tag: index, model: model)
        }
        return TableSection(id: Tag.Section.tvSeries, title: "TV Series", cells: cells)
    }

    struct State {
        var character: GOTCharacter
    }

    enum Tag {
        enum Section {
            static let gender = 0
            static let titles = 1
            static let aliases = 2
            static let allegiances = 3
            static let books = 4
            static let povBooks = 5
            static let tvSeries = 6
        }
    }
}
