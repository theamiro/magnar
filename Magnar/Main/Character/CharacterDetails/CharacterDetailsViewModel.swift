//
//  CharacterDetailsViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import Foundation

class CharacterDetailsViewModel: TableViewModel {
    var character: GOTCharacter

    init(character: GOTCharacter) {
        self.character = character
    }
}
