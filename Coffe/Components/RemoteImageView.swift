//
//  RemoteImageView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI
import Kingfisher

struct RemoteImageView: View {
    private let url: URL?
    init(url: URL?) {
        self.url = url
    }
    var body: some View {
        ZStack{
            KFImage(url)
                .resizable()
                .placeholder {Image(systemName: "photo")
                        .resizable()
                        .frame(maxWidth: 60, maxHeight: 60)
                        .foregroundColor(.gray)
                }
        }
    }
}

#Preview {
    RemoteImageView(url: DummyData.drinks.first?.imageURL)
}
