//
//  HouseDetailsViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

class HouseDetailsViewModel: TableBackedViewModel {
    var state: State
    private let characterService: GOTCharacterServiceDelegate

    init(house: House, characterService: GOTCharacterServiceDelegate = GOTCharacterService(networkService: NetworkService())) {
        self.state = State(house: house)
        self.characterService = characterService
        super.init()
        self.title = state.house.name
        self.sections = [
            TableSection(id: Tag.Section.region, title: "Region", cells: []),
            TableSection(id: Tag.Section.coatOfArms, title: "Coat of Arms", cells: []),
            TableSection(id: Tag.Section.words, title: "Words", cells: []),
            TableSection(id: Tag.Section.titles, title: "Titles", cells: []),
            TableSection(id: Tag.Section.members, title: "Sworn Members (\(state.house.swornMembers.count))", cells: [])
        ]
        makeRegionSection()
        makeCoatOfArmsSection()
        makeWordsSection()
        makeTitlesSection()
        if state.house.swornMembers.count > 0 {
            makeMembersSection()
        }
    }

    func makeRegionSection() {
        let model = SimpleTextFieldModel(text: state.house.region)
        self.sections[Tag.Section.region].cells.append(SimpleTextField(tag: 0, model: model))
    }

    func makeCoatOfArmsSection() {
        let model = SimpleTextFieldModel(text: state.house.coatOfArms)
        self.sections[Tag.Section.coatOfArms].cells.append(SimpleTextField(tag: 0, model: model))
    }

    func makeWordsSection() {
        let words = state.house.words == "" ? "No words" : state.house.words
        let model = SimpleTextFieldModel(text: words)
        self.sections[Tag.Section.words].cells.append(SimpleTextField(tag: 0, model: model))
    }

    func makeTitlesSection() {
        for index in state.house.titles.indices {

            let title = state.house.titles[index]
            let model = SimpleTextFieldModel(text: title == "" ? "No title" : title )
            self.sections[Tag.Section.titles].cells.append(SimpleTextField(tag: index, model: model))

        }
    }

    func makeMembersSection() {
        for memberIndex in state.house.swornMembers.indices {
            characterService.getCharacterByURL(url: state.house.swornMembers[memberIndex]) { [weak self] result in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                    break
                case .success(let character):
                    self?.state.house.members?.append(character)
                    let model = SimpleTextFieldModel(text: character.name)
                    self?.sections[Tag.Section.members].cells.append(SimpleTextField(tag: memberIndex, model: model))
                }
            }
        }
        redrawSection(Tag.Section.members)
    }
    struct State {
        var house: House
    }

    enum Tag {
        enum Section {
            static let region = 0
            static let coatOfArms = 1
            static let words = 2
            static let titles = 3
            static let members = 4
        }
    }
}
