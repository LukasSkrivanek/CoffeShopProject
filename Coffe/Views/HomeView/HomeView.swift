//
//  ContentView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(HomeViewModel.self) private var homeViewModel
    var body: some View {
                List(homeViewModel.filterCategories.keys.sorted(), id: \String.self){key in
                    Section {
                        if let drinks = homeViewModel.categories[key]{
                            ForEach(drinks, id: \.hashValue){drink in
                                DrinkRow(drink: drink){
                                    coordinator.push(page: .drinkDetail(drink))
                                }
                            }
                        }
                    } header: {
                        Text(key)
                            .font(.subheadline)
                    }
                }
            .searchable(text: .twoWay(\.searchText, on: homeViewModel),placement: .automatic, prompt: Text("Search for your drink"))
            .task {
                await homeViewModel.fetchDrinks()
            }
    }
}

#Preview {
    HomeView()
        .environment(HomeViewModel())
}
