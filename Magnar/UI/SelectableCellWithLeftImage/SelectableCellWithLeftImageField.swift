//
//  CharacterField.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import UIKit

class SelectableCellWithLeftImageField: TableRow {
    var reuseIdentifier = "SelectableCellWithLeftImage"
    var nibName = "SelectableCellWithLeftImage"
    var tag: Int
    var modelDidUpdate: (SelectableCellWithLeftImageFieldModel) -> Void = {_ in}

    var model: SelectableCellWithLeftImageFieldModel {
        didSet { modelDidUpdate(model) }
    }

    init(tag: Int, model: SelectableCellWithLeftImageFieldModel) {
        self.tag = tag
        self.model = model
    }

    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableBackedViewController?) -> UITableViewCell {
        guard let characterCell = cell as? SelectableCellWithLeftImage else { return cell }
        modelDidUpdate = characterCell.configure
        characterCell.configure(with: model)
        return characterCell
    }

    func preferredHeight(for indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
