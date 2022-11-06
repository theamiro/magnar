//
//  GOTCharacter.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

struct GOTCharacter: Decodable {
    let name, culture, born: String
    let aliases, playedBy: [String]
}
