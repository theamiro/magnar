//
//  BaseField.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import UIKit

class BaseField: TableRow {
    var reuseIdentifier = "BaseTableViewCell"
    var nibName = "BaseTableViewCell"
    var tag: Int
    var modelDidUpdate: (BaseFieldModel) -> Void = { _ in }
    var model: BaseFieldModel {
        didSet { modelDidUpdate(model) }
    }

    init(tag: Int, model: BaseFieldModel) {
        self.tag = tag
        self.model = model
    }

    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableBackedViewController?) -> UITableViewCell {
        guard let baseFieldCell = cell as? BaseTableViewCell else { return cell }
        modelDidUpdate = baseFieldCell.configure
        baseFieldCell.configure(with: model)

        return baseFieldCell
    }
    func preferredHeight(for indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
