//
//  Coordinator.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
