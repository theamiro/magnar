//
//  BaseTableViewCell.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var backgroundContentView: UIView!

    private var model: BaseFieldModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        titleLabel.textColor = UIColor(named: "labelColor")
        titleLabel.numberOfLines = 1
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.numberOfLines = 1
        backgroundContentView.layer.cornerRadius = 8.0
        selectionStyle = .none
    }

    func configure(with model: BaseFieldModel) {
        self.model = model
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.subtitle
    }
}
