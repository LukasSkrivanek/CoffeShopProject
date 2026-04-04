//
//  DrinkListViewModel.swift
//  CoffeCore
//

import Foundation
import Dependencies

@Observable
public final class DrinkListViewModel {

    @ObservationIgnored
    @Dependency(\.drinkRepository)
    private var drinkRepository

    public private(set) var drinks: [Drink] = []
    public private(set) var filterCategories: [String: [Drink]] = [:]
    public var searchText: String = "" {
        didSet { filterCategoriesFunc() }
    }

    public var categories: [String: [Drink]] {
        .init(grouping: drinks) { $0.category.rawValue }
    }

    public init() {}

    private func filterCategoriesFunc() {
        if searchText.isEmpty {
            filterCategories = categories
        } else {
            filterCategories = [:]
            for (key, drinks) in categories {
                let filtered = drinks.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                if !filtered.isEmpty {
                    filterCategories[key] = filtered
                }
            }
        }
    }

    public func fetchDrinks() async {
        do {
            drinks = try await drinkRepository.fetchDrinks()
            filterCategoriesFunc()
        } catch {
            print("Error fetching drinks:", error.localizedDescription)
        }
    }
}
