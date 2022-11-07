//
//  HouseFieldModel.swift
//  Magnar
//
//  Created by Michael Amiro on 04/11/2022.
//

import Foundation

struct HouseFieldModel {
    var title: String
    var subtitle: String
    var numberOfMembers: Int
    var tertiaryTitle: String
}
extension HouseFieldModel {
    init(with house: House) {
        self.title = house.name
        self.subtitle = house.region
        self.tertiaryTitle = house.words == "" ? "No words" : house.words
        self.numberOfMembers = house.swornMembers.count
    }
}
