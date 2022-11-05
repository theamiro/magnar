//
//  SimpleTextTableViewCell.swift
//  Magnar
//
//  Created by Michael Amiro on 04/11/2022.
//

import UIKit

class SimpleTextTableViewCell: UITableViewCell {
    @IBOutlet private weak var label: UILabel!

    private var model: SimpleTextFieldModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: "backgroundColor")
    }

    func configure(with model: SimpleTextFieldModel) {
        self.model = model

        label.text = model.text
    }
}
