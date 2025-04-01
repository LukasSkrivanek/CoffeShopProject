//
//  DrinkListViewController.swift
//  Coffe
//
//  Created by macbook on 22.03.2025.
//

import UIKit
import SwiftUI

final class DrinkListViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel = DependencyContainer.resolve(DrinkListViewModel.self)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        setupSearchController()
        setupTableView()
    }
    // MARK: - Setup
    private func setupView() {
        title = "Nabídka nápojů"
        view.backgroundColor = .systemBackground
    }
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DrinkTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for your drink"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    // MARK: - Data Loading
    private func loadData() {
        Task {
            await viewModel.fetchDrinks()
            tableView.reloadData()
            print("\(viewModel.filterCategories.count) count viewcontroller")
        }
    }
}
// MARK: - UITableViewDataSource
extension DrinkListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filterCategories.keys.count

    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.filterCategories.keys.sorted()[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = viewModel.filterCategories.keys.sorted()[section]
        return viewModel.filterCategories[key]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkTableViewCell", for: indexPath)
        let key = viewModel.filterCategories.keys.sorted()[indexPath.section]
        if let drink = viewModel.filterCategories[key]?[indexPath.row] {
            cell.contentConfiguration = UIHostingConfiguration {
                DrinkRow(drink: drink) {
                    print("Selected drink: \(drink.name)")
                }
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DrinkListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = viewModel.filterCategories.keys.sorted()[indexPath.section]
        if let drink = viewModel.filterCategories[key]?[indexPath.row] {
            (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.openBasketList()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension DrinkListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text ?? ""
    }
}
