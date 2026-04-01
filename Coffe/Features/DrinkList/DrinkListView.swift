//
//  ContentView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct DrinkListView: View {

    @Environment(Coordinator.self) private var coordinator

    @State
    private var viewModel = DrinkListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.filterCategories.keys.sorted(), id: \String.self) { key in
                Section {
                    if let drinks = viewModel.categories[key] {
                        ForEach(drinks, id: \.hashValue) { drink in
                            DrinkRow(drink: drink) {
                                coordinator.push(page: .drinkDetail(drink))
                            }
                        }
                    }
                } header: {
                    Text(key)
                        .font(.subheadline)
                }
            }
        }
        .searchable(
            text: .twoWay(\.searchText, on: viewModel),
            placement: .toolbar,
            prompt: Text("Search for your drink")
        )
        .task {
            await viewModel.fetchDrinks()
        }
    }
}

#Preview {
    DrinkListView()
        .environment(Coordinator())
}
