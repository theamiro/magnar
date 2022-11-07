//
//  HouseTableViewCell.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tertiaryTitleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!

    private var model: HouseFieldModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        selectionStyle = .none
    }

    func configure(with model: HouseFieldModel) {
        self.model = model

        titleLabel.text = model.title
        subtitleLabel.text = "Region: \(model.subtitle)"
        tertiaryTitleLabel.text = model.tertiaryTitle
        numberLabel.text = "\(model.numberOfMembers)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        tertiaryTitleLabel.text = nil
        numberLabel.text = nil
    }
}
