//
//  MockSecureStorageTests.swift
//  Coffe
//
//  Created by macbook on 20.03.2025.
//

import XCTest
@testable import Coffe

final class SecureStorage: XCTestCase {
    var mockSecureStorage: MockSecureStorage!

    override func setUpWithError() throws {
        mockSecureStorage = MockSecureStorage()
    }

    override func tearDownWithError() throws {
        mockSecureStorage = nil
    }

    func testSave_WhenDataIsSaved_ThenDataAndKeyAreStored() async {
        // Given
        let data = "Test Data".data(using: .utf8)
        let key = "testKey"

        // When
        await mockSecureStorage.save(data: data!, with: key)

        // Then
        XCTAssertEqual(mockSecureStorage.savedData, data, "Data should be saved")
        XCTAssertEqual(mockSecureStorage.keyUsed, key, "Key should be stored")
    }

    func testGet_WhenDataExists_ThenDataIsReturned() async {
        // Given
        let data = "Test Data".data(using: .utf8)
        mockSecureStorage.savedData = data

        // When
        let retrievedData = await mockSecureStorage.get(with: "testKey")

        // Then
        XCTAssertEqual(retrievedData, data, "Saved data should be returned")
    }

    func testGet_WhenNoDataExists_ThenNilIsReturned() async {
        // Given
        // No data is set up

        // When
        let retrievedData = await mockSecureStorage.get(with: "testKey")

        // Then
        XCTAssertNil(retrievedData, "No data should be returned")
    }

    func testDelete_WhenDataIsDeleted_ThenDataIsRemoved() async {
        // Given
        let data = "Test Data".data(using: .utf8)
        mockSecureStorage.savedData = data
        let key = "testKey"

        // When
        await mockSecureStorage.delete(with: key)

        // Then
        XCTAssertNil(mockSecureStorage.savedData, "Data should be deleted")
        XCTAssertEqual(mockSecureStorage.keyUsed, key, "Key should be stored")
    }
}
