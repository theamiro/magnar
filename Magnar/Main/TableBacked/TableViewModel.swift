//
//  TableViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class TableViewModel {
    var sections: [TableSection] = []
    var title: String = ""

    var redrawSection: (Int) -> Void = { _ in }
    var redrawRow: (IndexPath) -> Void = { _ in }
    var modelDidUpdate: () -> Void = {}

    func item(at indexPath: IndexPath) -> TableRow? {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].cells.count else {
            return nil
        }
        return sections[indexPath.section].cells[indexPath.row]
    }
    
    func item(at tag: Int) -> TableRow? {
        guard tag >= 0 else { return nil }
        for section in sections {
            for row in section.cells where row.tag == tag {
                return row
            }
        }
        return nil
    }

    deinit {
        print("\(self) deinit - - - - - - ")
    }
}
