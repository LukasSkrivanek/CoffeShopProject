//
//  DrinkDetailView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct DrinkDetailView: View {
    @Environment(Coordinator.self) private var coordinator
    
    @Environment(BasketViewModel.self) private var basketViewModel

    let drink: Drink
    
    var body: some View {
        VStack(spacing: 20) {
            RemoteImageView(url: drink.imageURL)
                .frame(maxWidth: .infinity, maxHeight: 250)

            VStack(spacing: 10) {
                Text(drink.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)

                Text(drink.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Text("\(drink.price, format: .currency(code: "EUR"))")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 47.8 / 255, green: 62.4 / 255, blue: 20.8 / 255))
                    .padding(.top)
                    .frame(maxHeight: .infinity)

                
                addToBasketButton()
                    .padding(.bottom, 30)
            }
            .padding(.top, 20)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
        .ignoresSafeArea(edges: .bottom)
        .overlay(alignment: .topTrailing) {
            dismissButton()
        }
    }

    @ViewBuilder
    private func addToBasketButton() -> some View {
        Button(action: {
            basketViewModel.add(drink: drink)
            coordinator.pop()
        }) {
            Text("Add to Basket")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(.brown)
                .cornerRadius(10)
                .font(.headline)
                .shadow(radius: 5)
        }
        .padding(.bottom, 20)
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    private func dismissButton() -> some View {
        Button(action: {
            coordinator.pop()
        }) {
            Image(systemName: "xmark.circle.fill")
                .scaleEffect(1.5)
                .padding(15)
                .foregroundColor(.white)
                .background(Color.brown.opacity(0.9))
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}
