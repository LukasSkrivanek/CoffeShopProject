//
//  FirebaseRepositoryTests.swift
//  Coffe
//
//  Created by macbook on 21.03.2025.
//

import XCTest
@testable import Coffe

class FirebaseRepositoryTests: XCTestCase {
    var mockRepository: FirebaseRepositoryMock!

    override func setUp() {
        super.setUp()
        mockRepository = FirebaseRepositoryMock()
    }

    func testFetchDrinks() async {
        let expectedDrinks = [MockData.drinkDummyData]
        mockRepository.fetchDrinksResult = .success(expectedDrinks)

        do {
            let drinks = try await mockRepository.fetchDrinks()
            XCTAssertEqual(drinks, expectedDrinks)
        } catch {
            XCTFail("Fetching drinks should not throw an error")
        }
    }

    func testSaveDrinks() {
        mockRepository.saveDrinks()
        XCTAssertTrue(mockRepository.saveDrinksCalled)
    }

    func testPlaceOrder() {
        let order = MockData.orderDummyData
        mockRepository.placeOrder(order: order)
        XCTAssertTrue(mockRepository.placeOrderCalled)
    }
}
