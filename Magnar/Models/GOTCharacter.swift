//
//  GOTCharacter.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

struct GOTCharacter: Decodable {
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let titles: [String]
    let aliases: [String]
    let playedBy: [String]
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
}
