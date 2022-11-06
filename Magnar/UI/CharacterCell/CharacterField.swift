//
//  CharacterField.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import UIKit

class CharacterField: TableRow {
    var reuseIdentifier = "CharacterTableViewCell"
    var nibName = "CharacterTableViewCell"
    var tag: Int
    var modelDidUpdate: (CharacterFieldModel) -> Void = {_ in}

    var model: CharacterFieldModel {
        didSet { modelDidUpdate(model) }
    }

    init(tag: Int, model: CharacterFieldModel) {
        self.tag = tag
        self.model = model
    }

    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableViewController?) -> UITableViewCell {
        guard let characterCell = cell as? CharacterTableViewCell else { return cell }
        modelDidUpdate = characterCell.configure
        characterCell.configure(with: model)
        return characterCell
    }

    func preferredHeight(for indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
