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


        sections = [
            TableSection(id: Tag.Section.gender, title: "Gender", cells:[]),
            TableSection(id: Tag.Section.born, title: "Born", cells:[]),
            TableSection(id: Tag.Section.culture, title: "Culture", cells:[]),
            TableSection(id: Tag.Section.titles, title: "Titles", cells:[]),
            TableSection(id: Tag.Section.aliases, title: "Aliases", cells:[]),
            TableSection(id: Tag.Section.allegiances, title: "Allegiances", cells:[]),
            TableSection(id: Tag.Section.books, title: "Books", cells:[]),
            TableSection(id: Tag.Section.povBooks, title: "POV Books", cells:[]),
            TableSection(id: Tag.Section.tvSeries, title: "TV Series", cells:[]),
        ]

        makeSimpleCell(using: state.character.gender, at: Tag.Section.gender)
        makeSimpleCell(using: state.character.born, at: Tag.Section.born)
        makeSimpleCell(using: state.character.culture, at: Tag.Section.culture)
        makeSequenceCells(using: state.character.titles, at: Tag.Section.titles)
        makeSequenceCells(using: state.character.aliases, at: Tag.Section.aliases)
        if state.character.allegiances.count > 0 {
            makeAllegiancesSection()
        }
        makeBooksSection()
        makePOVBooksSection()
        makeSequenceCells(using: state.character.tvSeries, at: Tag.Section.tvSeries)
    }

    func makeSimpleCell(using text: String, at section: Int) {
        let model = SimpleTextFieldModel(text: text == "" ? "No value" : text)
        self.sections[section].cells.append(SimpleTextField(tag: 0, model: model))
    }

    func makeSequenceCells(using array: [String], at section: Int) {
        for index in array.indices {
            let value = array[index]
            let model = SimpleTextFieldModel(text: value == "" ? "No value" : value)
            sections[section].cells.append(SimpleTextField(tag: index, model: model))
        }
    }

    func makeAllegiancesSection() {
        for index in state.character.books.indices {
            let house = state.character.allegiances[index]
            houseService.getHouseByURL(url: house) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.presentAlert("Error", error.localizedDescription)
                case .success(let house):
                    let model = SimpleTextFieldModel(text: house.name)
                    self?.sections[Tag.Section.allegiances].cells.append(SimpleTextField(tag: index, model: model))
                }
            }
        }
    }

    func makeBooksSection() {
        for index in state.character.books.indices {
            let book = state.character.books[index]
            bookService.getBookByURL(url: book) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.presentAlert("Error", error.localizedDescription)
                case .success(let book):
                    let model = SimpleTextFieldModel(text: book.name)
                    self?.sections[Tag.Section.books].cells.append(SimpleTextField(tag: index, model: model))
                }
            }
        }
    }

    func makePOVBooksSection() {
        for index in state.character.povBooks.indices {
            let book = state.character.povBooks[index]
            bookService.getBookByURL(url: book) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.presentAlert("Error", error.localizedDescription)
                case .success(let book):
                    let model = SimpleTextFieldModel(text: book.name)
                    self?.sections[Tag.Section.povBooks].cells.append(SimpleTextField(tag: index, model: model))
                }
            }
        }
    }

    struct State {
        var character: GOTCharacter
    }

    enum Tag {
        enum Section {
            static let gender = 0
            static let born = 1
            static let culture = 2
            static let titles = 3
            static let aliases = 4
            static let allegiances = 5
            static let books = 6
            static let povBooks = 7
            static let tvSeries = 8
        }
    }
}
