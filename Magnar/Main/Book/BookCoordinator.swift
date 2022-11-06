//
//  BookCoordinator.swift
//  Magnar
//
//  Created by Michael Amiro on 06/11/2022.
//

import UIKit

class BookCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = BooksViewController()
        viewController.coordinator = self
        let model = BooksViewModel()
        viewController.onRowSelected = model.onRowSelected
        model.goToBookDetailView = goToBookDetailView
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToBookDetailView(book: Book) {
        let viewController = BookDetailViewController()
        viewController.coordinator = self
        let model = BookDetailViewModel(book: book)
        viewController.viewModel = model
        navigationController.pushViewController(viewController, animated: true)
    }

}
