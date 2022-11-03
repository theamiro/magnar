//
//  TableRow.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

protocol TableRow: AnyObject {
    var reuseIdentifier: String { get }
    var nibName: String { get }
    var tag: Int { get }
}

extension TableRow {
    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableViewController? = nil) -> UITableViewCell {
        return cell
    }
}
