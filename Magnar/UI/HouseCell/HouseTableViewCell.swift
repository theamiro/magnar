//
//  HouseTableViewCell.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var overlordLabel: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!

    private var model: HouseFieldModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: HouseFieldModel) {
        self.model = model

        nameLabel.text = model.name
        regionLabel.text = "Region: \(model.region)"
        overlordLabel.text = model.overlord == "" ? "No overlord": model.overlord
        numberOfMembersLabel.text = "\(model.numberOfMembers)"
    }
}
