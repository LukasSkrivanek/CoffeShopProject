//
//  AccountViewModelTests.swift
//  Coffe
//
//  Created by macbook on 20.03.2025.
//

import XCTest
@testable import Coffe

class AccountViewModelTests: XCTestCase {
    var userRepository: UserRepositoryProtocol!
    var authenticationManager: AuthServiceProtocol!
    var secureStorage: SecureStorageProtocol!
    var viewModel: AccountViewModel!
    override func setUpWithError() throws {
        secureStorage = MockSecureStorage()
        userRepository = MockUserRepository(secureStorage: secureStorage)
        authenticationManager = MockAuthService()
        viewModel = AccountViewModel(userRepository: userRepository, authenticationManager: authenticationManager)
    }
    override func tearDownWithError() throws {
        secureStorage = nil
        userRepository = nil
        authenticationManager = nil
    }
    func testIsInvalid_WhenSuccess_ThenFalseIsReturned() {
        // Given

        // When
        viewModel.name = "Lukas"
        viewModel.address = "Some Address"
        viewModel.mobile = "123456789"

        // Then
        XCTAssertFalse(viewModel.isInvalidForm(), "Form should be valid")
    }
}
