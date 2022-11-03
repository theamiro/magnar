//
//  HouseField.swift
//  Magnar
//
//  Created by Michael Amiro on 04/11/2022.
//

import UIKit

class HouseField: TableRow {
    let nibName = "HouseTableViewCell"
    let reuseIdentifier = "HouseTableViewCell"

    let tag: Int

    var model: HouseFieldModel {
        didSet { modelDidUpdate(model) }
    }

    var modelDidUpdate: (HouseFieldModel) -> Void = { _ in }
    
    init(tag: Int, model: HouseFieldModel) {
        self.tag = tag
        self.model = model
    }

    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableViewController? = nil) -> UITableViewCell {
        guard let houseViewCell = cell as? HouseTableViewCell else { return cell }
        houseViewCell.configure(with: model)
        modelDidUpdate = houseViewCell.configure
        return houseViewCell
    }
}
