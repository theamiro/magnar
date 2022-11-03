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
        viewController.coordinator = self
        let viewModel = HouseViewModel()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: false)
    }
}
