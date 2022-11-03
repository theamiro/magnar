//
//  MainCoordinator.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = HouseViewController()
        let model = HouseViewModel()
        model.goToHouseDetailView = goToHouseDetailView
        viewController.coordinator = self
        viewController.viewModel = model
        viewController.onRowSelected = model.onRowSelected
        navigationController.pushViewController(viewController, animated: false)
    }

    func goToHouseDetailView(house: House) {
        let viewController = HouseDetailsViewController()
        viewController.coordinator = self
        let model = HouseDetailsViewModel(house: house)
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }
}
