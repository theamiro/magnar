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
    var modelDidUpdate: (HouseFieldModel) -> Void = { _ in }

    var model: HouseFieldModel {
        didSet { modelDidUpdate(model) }
    }

    init(tag: Int, model: HouseFieldModel) {
        self.tag = tag
        self.model = model
    }

    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableViewController? = nil) -> UITableViewCell {
        guard let houseViewCell = cell as? HouseTableViewCell else { return cell }
        modelDidUpdate = houseViewCell.configure

        houseViewCell.configure(with: model)

        return houseViewCell
    }

    func preferredHeight(for indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
