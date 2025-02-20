//
//  ContentView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct DrinkListView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(DrinkListViewModel.self) private var drinkListViewModel
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            List(drinkListViewModel.filterCategories.keys.sorted(), id: \String.self){ key in
                Section {
                    if let drinks = drinkListViewModel.categories[key] {
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
            .searchable(text: .twoWay(\.searchText, on: drinkListViewModel), placement: .toolbar, prompt: Text("Search for your drink"))
            .task {
                await drinkListViewModel.fetchDrinks()
            }
    }
}

#Preview {
    DrinkListView()
        .environment(DrinkListViewModel(firebaseRepository: FirebaseRepository()))
}
