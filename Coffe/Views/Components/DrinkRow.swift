//
//  DrinkRow.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct DrinkRow: View {
    
    private let drink: Drink
    var didClickRow: () -> Void
    
    init(drink: Drink, didClickRow: @escaping () -> Void) {
        self.drink = drink
        self.didClickRow = didClickRow
    }
    
    var body: some View {
        Button{
            didClickRow()
        } label: {
            HStack{
                RemoteImageView(url: drink.imageURL)
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 5){
                    Text(drink.name)
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("\(drink.price, format: .currency(code: "Eur"))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
                .padding(.leading)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
        }
        .tint(.black)
    }
}

#Preview {
    DrinkRow(drink: DummyData.drinks[0]){
        
    }
}
