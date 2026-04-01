//
//  BasketView.swift
//  Coffe
//
//  Created by macbook on 17.02.2025.
//

import SwiftUI

struct BasketView: View {

    @Environment(Coordinator.self) private var coordinator
    @Environment(\.colorScheme) private var colorScheme

    @State
    private var viewModel = BasketViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.items.isEmpty {
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
                        ForEach(viewModel.items, id: \.hashValue) { drink in
                            DrinkRow(drink: drink, didClickRow: {})
                                .allowsHitTesting(false)
                        }
                        .onDelete(perform: viewModel.deleteItems)
                    }
                    .listStyle(.grouped)
                    .safeAreaInset(edge: .bottom) {
                        placeOrderButton()
                    }
                }
            }
            .navigationTitle("🛒 Basket")
            .showCustomAlert(alert: .twoWay(\.showAlert, on: viewModel), colorScheme: colorScheme)
            .onChange(of: viewModel.showError) { _, showError in
                if showError {
                    viewModel.showAlert = AnyAppAlert(
                        title: "Error",
                        subtitle: viewModel.basketError?.description ?? "Unknown error",
                        buttons: {
                            AnyView(Button("OK") {
                                viewModel.showError = false
                            })
                        }
                    )
                }
            }
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
                            viewModel.createOrder()
                        }
                            .background(.brown)
                    )
                }
            )
        }, label: {
            Text("\(viewModel.totalPrice, format: .currency(code: "EUR")) - Place Order")
        })
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 30)
    }
}

#Preview {
    BasketView()
}
