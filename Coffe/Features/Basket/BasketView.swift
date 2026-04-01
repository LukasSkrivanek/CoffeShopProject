//
//  BasketView.swift
//  Coffe
//
//  Created by macbook on 17.02.2025.
//

import SwiftUI

struct BasketView: View {

    @Environment(Coordinator.self)
    private var coordinator

    @Environment(\.colorScheme)
    private var colorScheme

    @Environment(BasketState.self)
    private var basketState

    @State
    private var viewModel = BasketViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if basketState.items.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "list.bullet.clipboard")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.brown)
                            .font(.system(size: 120))
                    } description: {
                        Text("You have no items in your basket \n Please add some")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                } else {
                    List {
                        ForEach(basketState.items, id: \.hashValue) { drink in
                            DrinkRow(drink: drink, didClickRow: {})
                                .allowsHitTesting(false)
                        }
                        .onDelete { offsets in
                            basketState.remove(at: offsets)
                        }
                    }
                    .listStyle(.grouped)
                    .safeAreaInset(edge: .bottom) {
                        placeOrderButton()
                    }
                }
            }
            .navigationTitle("🛒 Basket")
            .showCustomAlert(alert: .twoWay(\.showAlert, on: viewModel), colorScheme: colorScheme)
        }
    }

    private func placeOrderButton() -> some View {
        Button(action: {
            viewModel.showAlert = AnyAppAlert(
                title: "Create Order?",
                subtitle: "Do you want to create an order for this basket?",
                buttons: {
                    AnyView(
                        Button("Create") {
                            viewModel.createOrder(from: basketState)
                        }
                        .background(.brown)
                    )
                }
            )
        }, label: {
            Text("\(basketState.totalPrice, format: .currency(code: "EUR")) - Place Order")
        })
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 30)
    }
}

#Preview {
    BasketView()
        .environment(BasketState())
}
