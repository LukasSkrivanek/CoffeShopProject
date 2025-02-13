//
//  CoordinatorVIew.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//

import SwiftUI

struct CoordinatorView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(\.colorScheme) private var colorScheme

    
    var body: some View {
        NavigationStack(path: .twoWay(\.path, on: coordinator)) {
            coordinator.build(page: .appTabBar)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item:.twoWay(\.sheet, on: coordinator)) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                        .preferredColorScheme(colorScheme)
                        .presentationDetents(coordinator.sheetDetent)
                       
                }
            
        }
    }
}
