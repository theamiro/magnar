//
//  CharacterTableViewCell.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import UIKit

class SelectableCellWithLeftImage: UITableViewCell {
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var tertiaryLabel: UILabel!
    @IBOutlet weak var quaternaryLabel: UILabel!

    private var model: SelectableCellWithLeftImageFieldModel?

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        leftImageView.layer.cornerRadius = 8
        selectionStyle = .none
    }

    func configure(with model: SelectableCellWithLeftImageFieldModel) {
        self.model = model
        
        primaryLabel.text = model.title
        tertiaryLabel.text = model.tertiaryTitle
        secondaryLabel.text = model.subtitle
        quaternaryLabel.text = model.quaternaryTitle
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        primaryLabel.text = nil
        tertiaryLabel.text = nil
        secondaryLabel.text = nil
        quaternaryLabel.text = nil
    }
}
