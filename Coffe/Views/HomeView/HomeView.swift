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
        ZStack{
            NavigationStack{
                List(homeViewModel.filterCategories.keys.sorted(), id: \String.self){key in
                    Section {
                        if let drinks = homeViewModel.categories[key]{
                            ForEach(drinks){drink in
                                DrinkRow(drink: drink){
                                    homeViewModel.selectDrink(drink: drink)
                                    homeViewModel.isShowingDetail = true
                                }
                            }
                        }
                    } header: {
                        Text(key)
                            .font(.subheadline)
                    }
                }
                .navigationTitle("☕️ Home")
                .searchable(text: .twoWay(\.searchText, on: homeViewModel),placement: .automatic, prompt: Text("Search for your drink"))
                .task {
                    await homeViewModel.fetchDrinks()
                }
                .blur(radius: homeViewModel.isShowingDetail ? 20 : 0)
                .disabled(homeViewModel.isShowingDetail)
                }
            if homeViewModel.isShowingDetail {
                if let drink = homeViewModel.selectedDrink{
                    DrinkDetailView(drink: drink, isShowingDetail: .twoWay(\.isShowingDetail, on: homeViewModel))
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(HomeViewModel())
}
