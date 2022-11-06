//
//  SelectableCellWithLeftImageFieldModel.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

struct SelectableCellWithLeftImageFieldModel {
    var title: String
    var subtitle: String
    var tertiaryTitle: String
    var quaternaryTitle: String

    init(name: String, culture: String, alias: String, playedBy: String) {
        self.title = name
        self.tertiaryTitle = culture
        self.subtitle = alias
        self.quaternaryTitle = playedBy
    }
}
extension SelectableCellWithLeftImageFieldModel {
    init(with character: GOTCharacter) {
        self.title = character.name == "" ? "Nameless" : character.name
        self.subtitle = character.aliases.first ?? ""
        self.tertiaryTitle = character.culture
        self.quaternaryTitle = character.playedBy.first ?? ""
    }
    
    init(with book: Book) {
        self.title = book.name
        self.subtitle = book.mediaType
        self.tertiaryTitle = book.publisher
        self.quaternaryTitle = book.authors.first ?? ""
    }
}
