//
//  BaseViewController.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class BaseViewController: UITabBarController {
    var coordinator: Coordinator?
    var viewModel: BaseViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
