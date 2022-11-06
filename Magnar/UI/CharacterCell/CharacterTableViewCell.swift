//
//  CharacterTableViewCell.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    @IBOutlet weak var cultureLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var playedByLabel: UILabel!

    private var model: CharacterFieldModel?

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        characterImageView.layer.cornerRadius = 8
        selectionStyle = .none
    }

    func configure(with model: CharacterFieldModel) {
        self.model = model
        
        nameLabel.text = model.name
        cultureLabel.text = model.culture
        aliasLabel.text = model.alias
        playedByLabel.text = model.playedBy
    }
}
