//
//  BasketView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct BasketView: View {
    @Environment(Coordinator.self) private var  coordinator
    @Environment(\.colorScheme) private var colorScheme
    
    @Environment(BasketViewModel.self) private var basketViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if basketViewModel.items.isEmpty {
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
                        ForEach(basketViewModel.items, id: \.hashValue) { drink in
                            DrinkRow(drink: drink, didClickRow: {})
                                .allowsHitTesting(false)
                        }
                        .onDelete(perform: basketViewModel.deleteItems)
                    }
                    .listStyle(.grouped)
                    .safeAreaInset(edge: .bottom) {
                        placeOrderButton()
                    }
                }
            }
            .navigationTitle("🛒 Basket")
            .showCustomAlert(alert: .twoWay(\.showAlert, on: basketViewModel), colorScheme: colorScheme)
            .onChange(of: basketViewModel.showError) { _, showError in
                if showError {
                    basketViewModel.showAlert = AnyAppAlert(
                        title: "Error",
                        subtitle: basketViewModel.basketError?.description ?? "Unknown error",
                        buttons: {
                            AnyView(Button("OK") {
                                basketViewModel.showError = false
                            })
                        }
                    )
                }
            }
        }
    }

    private func placeOrderButton() -> some View {
        Button(action: {
            basketViewModel.showAlert = AnyAppAlert(
                title: "Create Order?",
                subtitle: "Do you want to create an order for this basket?",
                buttons: {
                    AnyView(
                        Button("Create") {
                            basketViewModel.createOrder(for: basketViewModel.userRepository.user)
                        }
                            .background(.brown)
                        
                    )
                }
            )
        }, label: {
            Text("\(basketViewModel.totalPrice, format: .currency(code: "EUR")) - Place Order")
        })
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 30)
    }


}

#Preview {
    BasketView()
}
