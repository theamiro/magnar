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
    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableBackedViewController?) -> UITableViewCell
    func preferredHeight(for indexPath: IndexPath) -> CGFloat
}

extension TableRow {
    func configure(_ cell: UITableViewCell, indexPath: IndexPath, sender: TableBackedViewController? = nil) -> UITableViewCell {
        return cell
    }
    func preferredHeight(for indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
