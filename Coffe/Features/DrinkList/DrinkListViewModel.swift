//
//  HomeViewModel.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import Foundation

@Observable
final class DrinkListViewModel {
    var firebaseRepository: FirebaseRepository
    private(set) var drinks: [Drink] = []
    private(set) var selectedDrink: Drink?
    private(set)var filterCategories: [String: [Drink]] = [:]
    init(firebaseRepository: FirebaseRepository) {
        self.firebaseRepository = firebaseRepository
    }
    var isShowingDetail = false
    var searchText: String = "" {
        didSet {
            filterCategoriesFunc()
        }
    }
    var categories: [String: [Drink]] {
        .init(
            grouping: drinks) { $0.category.rawValue }
    }
    private func filterCategoriesFunc() {
            if searchText.isEmpty {
                filterCategories = categories
        } else {
            filterCategories = [:]
            for (key, drinks) in categories {
                let filteredDrinks = drinks.filter { $0.name.lowercased().contains(searchText.lowercased())}
                if !filteredDrinks.isEmpty {
                    filterCategories[key] = filteredDrinks
                }
            }
        }
    }
     func fetchDrinks() async {
        do {
            drinks = try await firebaseRepository.fetchDrinks()
            filterCategoriesFunc()
        } catch {
            print("Error fetching drinks", error.localizedDescription)
        }
    }
    func selectDrink(drink: Drink) {
        selectedDrink = drink
    }
}
