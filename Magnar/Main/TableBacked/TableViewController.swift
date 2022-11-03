//
//  TableViewController.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class TableViewController: UIViewController {
    var coordinator: Coordinator?
    var onRowSelected: (IndexPath) -> Void = { _ in }
    var knownIdentifiers: [String] = []

    var viewModel: TableViewModel! {
        didSet {
            viewModel.modelDidUpdate = { [weak self] in self?.updateTable() }
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerCellNIBs()

        title = viewModel?.title
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func registerCellNIBs() {
        for section in viewModel.sections {
            for row in section.cells {
                guard !knownIdentifiers.contains(row.reuseIdentifier) else { continue }
                let nib = UINib(nibName: row.nibName, bundle: .main)
                tableView.register(nib, forCellReuseIdentifier: row.reuseIdentifier)
                knownIdentifiers.append(row.reuseIdentifier)
            }
        }
    }

    func updateTable() {
        registerCellNIBs()
        tableView.reloadData()
    }

    func redrawRow(indexPath: IndexPath) {
        registerCellNIBs()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }

    func redrawSection(section: Int) {
        registerCellNIBs()
        tableView.reloadSections(IndexSet([section]), with: .fade)
    }

    func registerCellNIBsIfNeeded() {
        if viewModel.sections.count > 0 && knownIdentifiers.isEmpty {
            registerCellNIBs()
        }
    }
}
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        registerCellNIBsIfNeeded()
        return viewModel?.sections.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        registerCellNIBsIfNeeded()
        return viewModel?.sections[section].cells.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = viewModel?.item(at: indexPath) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath)
        return cellType.configure(cell, indexPath: indexPath, sender: self)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onRowSelected(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
