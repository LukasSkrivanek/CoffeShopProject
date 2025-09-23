//
//  DrinkListViewController.swift
//  Coffe
//
//  Created by macbook on 22.03.2025.
//

import SwiftUI
import UIKit
import ComposableArchitecture
import SnapKit

@Reducer
struct DrinkListItem {
  @ObservableState
  struct State: Equatable, Identifiable {
    let id = UUID()
    var drink: Drink
  }

  enum Action {
    case some
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .some:
        return .none
      }
    }
  }
}

extension DependencyValues {
    var dataSource: any DataSource {
        get { self[DataSourceKey.self] }
        set { self[DataSourceKey.self] = newValue }
    }
    
    private enum DataSourceKey: DependencyKey {
      static let liveValue: any DataSource = FirebaseRepository()
      static let testValue: any DataSource = FirebaseRepository()
    }
}

protocol DataSource {
    func fetchDrinks() async throws -> [Drink]
}

@Reducer
struct DrinkList {
  @ObservableState
  struct State: Equatable {
    var drinks: [Drink] = []
    var filterCategories: [String: [Drink]] = [:]
  }

  enum Action {
    case loadDrinks
    case renderDrinks([Drink])
  }

  @Dependency(\.dataSource) var dataSource
    
  var body: some Reducer<State, Action> {
      Reduce { state, action in
          switch action {
            case .loadDrinks:
              return .run { send in
                  let drinks = try await dataSource.fetchDrinks()
                  await send(.renderDrinks(drinks))
              }
          case .renderDrinks(let drinks):
              state.drinks = drinks
              state.filterCategories = categories(drinks: drinks)
              return .none
          }
      }
  }
    
    func categories(drinks: [Drink]) -> [String: [Drink]] {
        .init(grouping: drinks) { $0.category.rawValue }
    }
}

final class DrinkListViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // Mark: - CTA
    private let store: StoreOf<DrinkList>
    var observations: [IndexPath: ObserveToken] = [:]
    
    // MARK: - Lifecycle
    init(store: StoreOf<DrinkList>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
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

        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        observe { [weak self] in
            self?.tableView.reloadData()
        }
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
            store.send(.loadDrinks)
        }
    }
}
// MARK: - UITableViewDataSource
extension DrinkListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.filterCategories.keys.count

    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return store.filterCategories.keys.sorted()[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = store.filterCategories.keys.sorted()[section]
        return store.filterCategories[key]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkTableViewCell", for: indexPath)
        let key = store.filterCategories.keys.sorted()[indexPath.section]
        observations[indexPath]?.cancel()
        observations[indexPath] = observe { [weak self] in
            guard let self, let drink = store.filterCategories[key]?[indexPath.row] else { return }

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
        /*let key = viewModel.filterCategories.keys.sorted()[indexPath.section]
        if let drink = viewModel.filterCategories[key]?[indexPath.row] {
            (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.open(drink: drink)
        }*/
    }
}

// MARK: - UISearchResultsUpdating
extension DrinkListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // viewModel.searchText = searchController.searchBar.text ?? ""
    }
}
