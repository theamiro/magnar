//
//  HouseService.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

protocol HouseServiceDelegate {
    func getHouses(completion: @escaping(Result<[House], NetworkError>) -> Void)
}

class HouseService: HouseServiceDelegate {
    var networkService: NetworkServiceDelegate

    init(networkService: NetworkServiceDelegate) {
        self.networkService = networkService
    }

    func getHouses(completion: @escaping(Result<[House], NetworkError>) -> Void) {
        networkService.fetch(url: "https://anapioficeandfire.com/api/houses", type: [House].self, completion: completion)
    }
}
