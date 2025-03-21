//
//  DrinkListViewModelTests.swift
//  Coffe
//
//  Created by macbook on 21.03.2025.
//

import XCTest
@testable import Coffe

class DrinkListViewModelTests: XCTestCase {
    var firebaseRepository: FirebaseRepositoryProtocol!
    var viewModel: DrinkListViewModel!
    var drinks: [Drink] = []
    override func setUpWithError() throws {
        firebaseRepository = FirebaseRepositoryMock()
        viewModel = DrinkListViewModel(firebaseRepository: firebaseRepository)
    }
    override func tearDownWithError() throws {
        firebaseRepository = nil
        drinks = []
    }
    func testFilterCategories_WhenSearchTextSet_FiltersCorrectly() {
        // Given
        viewModel.drinks = [
            MockData.drinkDummyData
        ]
        // When
        viewModel.searchText = "Coffe"
        // Then
        XCTAssertEqual(viewModel.filterCategories.count, 1, "Should be find only one category")
    }
    func testSelectDrink_SetsSelectedDrink() {
        // Given
        let drink = MockData.drinkDummyData
        // When
        viewModel.selectDrink(drink: drink)
        // Then
        XCTAssertNotNil(viewModel.selectedDrink, "Selected drink should not be nil")
        XCTAssertEqual(viewModel.selectedDrink?.name, "Coffe", "Picked drink should be 'Coffe'")
    }

}
