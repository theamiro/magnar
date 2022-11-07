//
//  CharacterService.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import Foundation

protocol GOTCharacterServiceDelegate {
    func getCharacters(completion: @escaping(Result<[GOTCharacter], NetworkError>) -> Void)
    func getCharacterByURL(url: String, completion: @escaping(Result<GOTCharacter, NetworkError>) -> Void)
}

class GOTCharacterService: GOTCharacterServiceDelegate {
    var networkService: NetworkServiceDelegate

    init(networkService: NetworkServiceDelegate) {
        self.networkService = networkService
    }

    func getCharacters(completion: @escaping(Result<[GOTCharacter], NetworkError>) -> Void) {
        if networkService.shouldMock {
            networkService.fetch(resource: "characters", type: [GOTCharacter].self, completion: completion)
        } else {
            networkService.fetch(url: "https://anapioficeandfire.com/api/characters", type: [GOTCharacter].self, completion: completion)
        }
    }
    
    func getCharacterByURL(url: String, completion: @escaping(Result<GOTCharacter, NetworkError>) -> Void) {
        if networkService.shouldMock {
            networkService.fetch(resource: "characters", type: GOTCharacter.self, completion: completion)
        } else {
            networkService.fetch(url: url, type: GOTCharacter.self, completion: completion)
        }
    }
}
