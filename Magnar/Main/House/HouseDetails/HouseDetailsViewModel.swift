//
//  HouseDetailsViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

class HouseDetailsViewModel {
    var state: State

    init(house: House) {
        self.state = State(house: house)
    }
    struct State {
        var house: House
    }
}
