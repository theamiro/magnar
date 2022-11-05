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

    //    func start() {
    //        let viewController = HouseViewController()
    //        let model = HouseViewModel()
    //        model.goToHouseDetailView = goToHouseDetailView
    //        viewController.coordinator = self
    //        viewController.viewModel = model
    //        viewController.onRowSelected = model.onRowSelected
    //        navigationController.pushViewController(viewController, animated: false)
    //    }

    func start() {
        let viewController = BaseViewController()
        let model = BaseViewModel()
        model.goToCharactersView = goToCharactersView
        model.goToHousesView = goToCharactersView
//        model.goToBooksView = goToBooksView
        viewController.coordinator = self
        viewController.viewModel = model
        viewController.onRowSelected = model.onRowSelected
        navigationController.pushViewController(viewController, animated: false)
    }

    func goToHousesView() {
        let viewController = HouseViewController()
        let model = HouseViewModel()
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToHouseDetailView(house: House) {
        let viewController = HouseDetailsViewController()
        viewController.coordinator = self
        let model = HouseDetailsViewModel(house: house)
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToCharactersView() {
        let viewController = CharacterViewController()
        let model = CharacterViewModel()
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

//    func goToBooksView() {
//        let viewController = BooksViewController()
//        let model = BooksViewModel()
//        viewController.viewModel = model
//        navigationController.pushViewController(viewController, animated: true)
//    }
//
//    func goToBooksDetailView(book: Book) {
//        let viewController = BookDetailsViewController()
//        viewController.coordinator = self
//        let model = BookDetailsViewModel(character: character)
//        viewController.viewModel = model
//        navigationController.pushViewController(viewController, animated: true)
//    }
}
