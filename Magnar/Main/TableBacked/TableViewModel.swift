//
//  TableViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class TableViewModel {
    var sections: [TableSection]
    var title: String

    init(sections: [TableSection] = [], title: String = "") {
        self.sections = sections
        self.title = title
    }
}
