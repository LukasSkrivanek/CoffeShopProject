//
//  CoordinatorVIew.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//

import SwiftUI

struct CoordinatorView: View {
    @State private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .appTabBar)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
        }
    }
}
