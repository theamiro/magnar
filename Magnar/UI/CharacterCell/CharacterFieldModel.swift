//
//  CharacterFieldModel.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

struct CharacterFieldModel {
    var name, culture, born: String
    var alias: String
    var playedBy: String

    init(name: String, culture: String, born: String, alias: String, playedBy: String) {
        self.name = name
        self.culture = culture
        self.born = born
        self.alias = alias
        self.playedBy = playedBy
    }
}
extension CharacterFieldModel {
    init(with character: GOTCharacter) {
        self.name = character.name == "" ? "Nameless" : character.name
        self.culture = character.culture
        self.born = character.born
        self.alias = character.aliases.first ?? ""
        self.playedBy = character.playedBy.first ?? ""
    }
}
