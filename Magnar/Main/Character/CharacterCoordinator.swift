//
//  CharacterCoordinator.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import UIKit

class CharacterCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = CharacterViewController()
        viewController.coordinator = self
        let model = CharacterViewModel()
        viewController.onRowSelected = model.onRowSelected
        model.goToCharacterDetailView = goToCharacterDetailView
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToCharacterDetailView(character: GOTCharacter) {
        let viewController = CharacterViewController()
        viewController.coordinator = self
        let model = CharacterDetailsViewModel(character: character)
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }
}
