//
//  ContentView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        ZStack{
            NavigationStack{
                List(viewModel.filterCategories.keys.sorted(), id: \String.self){key in
                    Section {
                        if let drinks = viewModel.categories[key]{
                            ForEach(drinks){drink in
                                DrinkRow(drink: drink){
                                    viewModel.selectDrink(drink: drink)
                                    viewModel.isShowingDetail = true
                                }
                            }
                        }
                    } header: {
                        Text(key)
                            .font(.subheadline)
                    }

                }
                .navigationTitle("☕️ Home")
                .searchable(text: $viewModel.searchText,placement: .automatic, prompt: Text("Search for your drink"))
                .task {
                    await viewModel.fetchDrinks()
                }
                .blur(radius: viewModel.isShowingDetail ? 20 : 0)
                .disabled(viewModel.isShowingDetail)
                }
            if viewModel.isShowingDetail {
                if let drink = viewModel.selectedDrink{
                    DrinkDetailView(drink: drink, isShowingDetail: $viewModel.isShowingDetail)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(HomeViewModel())
}
