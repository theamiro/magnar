//
//  MainCoordinator.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class MainCoordinator: NSObject, UINavigationControllerDelegate, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        let viewController = HomeViewController()
        viewController.coordinator = self
        let model = HomeViewModel()
        model.goToCharactersView = goToCharactersView
        model.goToHousesView = goToHousesView
        model.goToBooksView = goToBooksView
        viewController.viewModel = model
        viewController.onRowSelected = model.onRowSelected
        navigationController.pushViewController(viewController, animated: false)
    }

    func goToHousesView() {
        let coordinator = HouseCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func goToCharactersView() {
        let coordinator = CharacterCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func goToBooksView() {
        let coordinator = BookCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let viewController = fromViewController as? TableBackedViewController {
            completeWorkflow(viewController.coordinator)
        }
    }
    
    func completeWorkflow(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
}
