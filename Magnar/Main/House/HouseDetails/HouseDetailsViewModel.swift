//
//  HouseDetailsViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

class HouseDetailsViewModel: TableBackedViewModel {
    var state: State

    init(house: House) {
        self.state = State(house: house)
        super.init()
        self.title = state.house.name
        self.sections = [
            TableSection(id: Tag.Section.members, title: "Region", cells: []),
            TableSection(id: Tag.Section.members, title: "Sworn Members", cells: [])
        ]
        makeRegionSection()
        makeMembersSection()
    }

    func makeRegionSection() {
        let model = SimpleTextFieldModel(text: state.house.region)
        self.sections[Tag.Section.region].cells.append(SimpleTextField(tag: 0, model: model))
    }

    func makeMembersSection() {
        for index in state.house.swornMembers.indices {
            let member = state.house.swornMembers[index]
            let model = SimpleTextFieldModel(text: member)
            self.sections[Tag.Section.members].cells.append(SimpleTextField(tag: index, model: model))
        }
    }
    struct State {
        var house: House
    }

    enum Tag {
        enum Section {
            static let region = 0
            static let members = 1
        }
    }
}
