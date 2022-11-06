//
//  HouseFieldModel.swift
//  Magnar
//
//  Created by Michael Amiro on 04/11/2022.
//

import Foundation

struct HouseFieldModel {
    var name: String = "Sample"
    var region: String = "Sample"
    var numberOfMembers: Int = 45
    var overlord: String = "Sample"
}
extension HouseFieldModel {
    init(with house: House) {
        self.name = house.name
        self.region = house.region
        self.numberOfMembers = house.swornMembers.count
        self.overlord = house.overlord == "" ? "No overload" : house.overlord
    }
}
