//
//  SimpleTextTableViewCell.swift
//  Magnar
//
//  Created by Michael Amiro on 04/11/2022.
//

import UIKit

class SimpleTextTableViewCell: UITableViewCell {
    @IBOutlet weak var contentBackgroundView: UILabel!
    @IBOutlet private weak var label: UILabel!

    private var model: SimpleTextFieldModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentBackgroundView.backgroundColor = .systemBackground
        contentBackgroundView.layer.cornerRadius = 8
        backgroundColor = UIColor(named: "backgroundColor")
        selectionStyle = .none
    }

    func configure(with model: SimpleTextFieldModel) {
        self.model = model

        label.text = model.text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
}
