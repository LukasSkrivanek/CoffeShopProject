//
//  UserRepositoryTests.swift
//  Coffe
//
//  Created by macbook on 20.03.2025.
//
import XCTest
@testable import Coffe

final class UserRepositoryTests: XCTestCase {
    var mockSecureStorage: SecureStorageProtocol!
    var mockUserRepository: UserRepositoryProtocol!

    override func setUp() {
        super.setUp()
        mockSecureStorage = MockSecureStorage()
        mockUserRepository = MockUserRepository(secureStorage: mockSecureStorage)
    }

    override func tearDown() {
        mockUserRepository = nil
        mockSecureStorage = nil
        super.tearDown()
    }

    func testLoadUser_ReturnsMockUser() async {
        // Given
        let expectedName = "Lukas"

        // When
        let user = await mockUserRepository.loadUser()

        // Then
        XCTAssertNotNil(user, "Uživatel by neměl být nil")
        XCTAssertEqual(user?.name, expectedName, "Jméno uživatele by mělo být 'Lukas'")
    }

    func testFetchUser_ReturnsMockUser() async {
        // Given
        let expectedEmail = "kuky.skrivos@gmail.com"

        // When
        let user = await mockUserRepository.fetchUser()

        // Then
        XCTAssertNotNil(user, "User should not be nil")
        XCTAssertEqual(user?.email, expectedEmail, "Email should be equal")
    }
}
