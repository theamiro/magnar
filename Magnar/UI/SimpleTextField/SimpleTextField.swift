//
//  SimpleTextCell.swift
//  Magnar
//
//  Created by Michael Amiro on 04/11/2022.
//

import UIKit

class SimpleTextField: TableRow {
    var reuseIdentifier = "SimpleTextTableViewCell"
    var nibName = "SimpleTextTableViewCell"
    var tag: Int
    var modelDidUpdate: (SimpleTextFieldModel) -> Void = { _ in }

    var model: SimpleTextFieldModel {
        didSet { modelDidUpdate(model) }
    }

    init(tag: Int, model: SimpleTextFieldModel) {
        self.tag = tag
        self.model = model
    }

    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableBackedViewController?) -> UITableViewCell {
        guard let simpleTextCell = cell as? SimpleTextTableViewCell else { return cell }
        modelDidUpdate = simpleTextCell.configure

        simpleTextCell.configure(with: model)

        return simpleTextCell
    }

    func preferredHeight(for indexPath: IndexPath) -> CGFloat {
        return 54.0
    }

}
