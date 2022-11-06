//
//  TableBackedViewController.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class TableBackedViewController: UIViewController {
    var coordinator: Coordinator?
    var onRowSelected: (IndexPath) -> Void = { _ in }
    var knownIdentifiers: [String] = []

    var viewModel: TableBackedViewModel! {
        didSet {
            viewModel.modelDidUpdate = { [weak self] in
                DispatchQueue.main.async {
                    self?.updateTable()
                }
            }
            viewModel.redrawRow = { [weak self] in self?.redrawRow(indexPath: $0) }
            viewModel.redrawSection = { [weak self] in self?.redrawSection(section: $0) }
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        registerCellNIBs()
        view.backgroundColor = UIColor(named: "backgroundColor")

        title = viewModel?.title
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor(named: "labelColor")

    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
    func setupTableHeaderView(with section: TableSection) -> UIView {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .secondaryLabel
            label.numberOfLines = 1
            label.text = section.title
            return label
        }()
        let headerView = UIView()

        headerView.addSubview(titleLabel)
        headerView.addConstraints([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        return headerView
    }
}
extension TableBackedViewController: UITableViewDataSource, UITableViewDelegate {
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = viewModel?.sections[section] else { return nil }
        return setupTableHeaderView(with: section)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onRowSelected(indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = viewModel?.item(at: indexPath) else {
            return view.bounds.height
        }
        return cellType.preferredHeight(for: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel?.sections[section].title != nil else { return 0 }
        return 32
    }
}
