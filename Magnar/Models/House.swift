//
//  House.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

struct House: Decodable {
    let url, name, region, coatOfArms, words, currentLord, heir, overlord: String
    let titles, seats, swornMembers: [String]
    var id: Int {
        return Int(url.split(separator: "/").last ?? "0") ?? 0
    }
}
