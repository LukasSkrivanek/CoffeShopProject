//
//  AccountViewModel.swift
//  Coffe
//
//  Created by Skrivanek, Lukas on 01.04.2026.
//

import Foundation
import Observation
import Dependencies

@Observable
final class AccountViewModel {

    @ObservationIgnored
    @Dependency(\.userRepository)
    var userRepository

    @ObservationIgnored
    @Dependency(\.authenticationManager)
    private var authenticationManager

    var name = ""
    var address = ""
    var mobile = ""
    var email = ""

    func isInvalidForm() -> Bool {
        name.isEmpty || address.isEmpty || mobile.isEmpty
    }

    func logOut() {
        do {
            try authenticationManager.signOut()
            userRepository.removeUser()
        } catch {
            print("Error")
        }
    }
}
