//
//  HouseViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

class HouseViewModel: TableViewModel {
    init() {
        super.init()
        self.sections = [TableSection(id: 0, cells: [TableRow(message: "Michael Amiro")])]
        self.title = "Houses"
    }
}
