//
//  CoffeUnitTests.swift
//  CoffeUnitTests
//
//  Created by macbook on 19.03.2025.
//
import Foundation
import XCTest
@testable import Coffe

class AuthServiceTests: XCTestCase {
    var mockAuthService: AuthServiceProtocol!
    override func setUpWithError() throws {
        mockAuthService = MockAuthService()
    }
    override func tearDownWithError() throws {
        mockAuthService = nil
    }
    func testCreateUser_WhenSuccess_ThenAuthDataIsReturned() async {
        // Given
        let email = "john@example.com"
        let password = "password123"

        // When
        let authData = try? await mockAuthService.createUser(email: email, password: password)

        // Then
        XCTAssertNotNil(authData, "Auth data should be returned")
        XCTAssertEqual(authData?.user.email, "test@example.com", "Auth data email should match")
    }
    func testSignInUser_WhenSuccess_ThenAuthDataIsReturned() async {
        // Given
        let email = "john@example.com"
        let password = "password123"

        // When
        let authData = try? await mockAuthService.signInUser(email: email, password: password)

        // Then
        XCTAssertNotNil(authData, "Auth data should be returned")
        XCTAssertEqual(authData?.user.email, "test@example.com", "Auth data email should match")
    }
    func testGetAuthenticatedUser_WhenSuccess_ThenAuthDataIsReturned() {
        // Given

        // When
        let authData = try? mockAuthService.getAuthenticatedUser()

        // Then
        XCTAssertNotNil(authData, "Auth data should be returned")
        XCTAssertEqual(authData?.user.email, "test@example.com", "Auth data email should match")
    }
    func testResetPassword_WhenSuccess_ThenNoErrorIsThrown() async {
        // Given
        let email = "john@example.com"

        // When & Then
        do {
            try await mockAuthService.resetPassword(email: email)
        } catch {
            XCTFail("Expected no error to be thrown")
        }
    }

    func testUpdateEmail_WhenSuccess_ThenNoErrorIsThrown() async {
        // Given
        let email = "new@example.com"

        // When & Then
        do {
            try await mockAuthService.updateEmail(email: email)
        } catch {
            XCTFail("Expected no error to be thrown")
        }
    }

    func testSignOut_WhenSuccess_ThenNoErrorIsThrown() {
        // Given
        let mockAuthService = MockAuthService()

        // When & Then
        XCTAssertNoThrow(try mockAuthService.signOut(), "Sign out should not throw an error")
    }
}
