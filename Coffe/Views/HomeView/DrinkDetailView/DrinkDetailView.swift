//
//  DrinkDetailView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct DrinkDetailView: View {
    let drink: Drink
    @Environment(BasketViewModel.self) private var order
    @Binding var isShowingDetail: Bool
    var body: some View {
        VStack(spacing: 10){
            RemoteImageView(url: drink.imageURL)
                .frame(width: 300, height: 225)
                .aspectRatio(contentMode: .fit)
            VStack{
                Text(drink.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(drink.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
            }
            Spacer()
            addToBasketButton()
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .shadow(radius: 4)
        .overlay(alignment: .topTrailing) {
            dismissButton()
        }
    }
    @ViewBuilder
    private func addToBasketButton() -> some View {
        Button(action: {
            order.add(drink: drink)
            isShowingDetail = false
        }, label: {
            Text("\(drink.price, format: .currency(code: "EUR")) - Add to Basket")
        })
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 30)
    }
    
    @ViewBuilder
    private func dismissButton() -> some View {
        Button(action: {
            isShowingDetail = false
        }, label: {
           Image(systemName: "xmark.circle.fill")
                .scaleEffect(1.5)
                .padding()
                .foregroundStyle(.gray)
        })
    }
}

#Preview {
    DrinkDetailView(drink: DummyData.drinks[0], isShowingDetail: .constant(true))
}
