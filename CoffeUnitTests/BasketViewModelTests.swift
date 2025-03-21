//
//  BasketViewModel.swift
//  Coffe
//
//  Created by macbook on 21.03.2025.
//

import XCTest
@testable import Coffe

class BasketViewModelTests: XCTestCase {
    var firebaseRepository: FirebaseRepositoryProtocol!
    var userRepository: UserRepositoryProtocol!
    var secureStorage: MockSecureStorage!
    var basketViewModel: BasketViewModel!
    override func setUpWithError() throws {
        secureStorage = MockSecureStorage()
        firebaseRepository = FirebaseRepositoryMock()
        userRepository = MockUserRepository(secureStorage: secureStorage)
        basketViewModel = BasketViewModel(userRepository: userRepository, firebaseRepository: firebaseRepository)
    }
    override func tearDownWithError() throws {
        secureStorage = nil
        firebaseRepository = nil
        secureStorage = nil
    }
    func testAddDrink_IncreasesItemCount() {
        // Given
        let drink = MockData.drinkDummyData
        // When
        basketViewModel.add(drink: drink)
        // Then
        XCTAssertEqual(basketViewModel.items.count, 1, "Count should be one")
    }
    func testDeleteItems_RemovesCorrectItem() {
        // Given
        let drink1 = MockData.drinkDummyData
        let drink2 =  MockData.drinkDummyData
        basketViewModel.add(drink: drink1)
        basketViewModel.add(drink: drink2)
        // When
        basketViewModel.deleteItems(at: IndexSet(integer: 0))
        // Then
        XCTAssertEqual(basketViewModel.items.count, 1, "Count should be one")
    }
    func testCreateOrder_WithEmptyBasket_ShowsError() {
        // Given
        // When
        basketViewModel.createOrder()
        // Then
        XCTAssertEqual(basketViewModel.basketError, .emptyBasketError, "Empty basket error")
    }
    func testCreateOrder_WithNoUser_ShowsError() {
        // Given
        // When
        basketViewModel.createOrder()
        // Then
        XCTAssertTrue(basketViewModel.showError, "Error should be shown")
    }
}
