//
//  BaseCoordinator.swift
//  Magnar
//
//  Created by Michael Amiro on 05/11/2022.
//

import UIKit

class HouseCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HouseViewController()
        viewController.coordinator = self
        let model = HouseViewModel()
        viewController.onRowSelected = model.onRowSelected
        model.goToHouseDetailView = goToHouseDetailView
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToHouseDetailView(house: House) {
        let viewController = HouseDetailsViewController()
        viewController.coordinator = self
        let model = HouseDetailsViewModel(house: house)
        model.redrawSection = viewController.redrawSection
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }
}
