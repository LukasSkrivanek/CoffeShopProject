//
//  Coordinator.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//

import Foundation
import SwiftUI

@Observable
class Coordinator {
    var path : NavigationPath = NavigationPath()
    var sheet: Sheet?
    var fullScreenCover: FullScreenCorver?
    
    
    func push(page: AppPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        if !path.isEmpty {
            path.removeLast(path.count)
        }
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: FullScreenCorver) {
        fullScreenCover = cover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissCover() {
        fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .appTabBar: AppTabView()
        case .home: HomeView()
        case .account: AccountView(isSignedIn: .constant(true))
        case .basket: BasketView()
        }
    }
    

    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .loginMethod: LoginMethodSelectionView()
        case .registration: RegistrationView(isPresented: .constant(true), isSignedIn: .constant(true))
            
        }
        
    }
}
