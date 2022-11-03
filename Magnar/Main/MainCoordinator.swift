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
        viewController.coordinator = self
        viewController.viewModel = model
        viewController.onRowSelected = model.onRowSelected
        navigationController.pushViewController(viewController, animated: false)
    }
}
