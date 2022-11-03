//
//  HouseDetailsViewController.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class HouseDetailsViewController: UIViewController {
    var coordinator: Coordinator?
    var viewModel: HouseDetailsViewModel?
    lazy var houseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(houseNameLabel)
        houseNameLabel.text = viewModel?.state.house.name
        view.addConstraints([
            houseNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            houseNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            houseNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            houseNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
