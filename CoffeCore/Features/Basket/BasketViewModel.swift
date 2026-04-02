//
//  BasketViewModel.swift
//  CoffeCore
//

import Foundation
import Dependencies

@Observable
public final class BasketViewModel {

    @ObservationIgnored
    @Dependency(\.userRepository)
    private var userRepository

    @ObservationIgnored
    @Dependency(\.drinkRepository)
    private var drinkRepository

    @ObservationIgnored
    @Dependency(\.sessionValidator)
    private var sessionValidator

    public var alert: CoreAlert?

    public init() {}

    public func createOrder(from basketState: BasketState) {
        guard !basketState.items.isEmpty else {
            alert = .error(.emptyBasketError)
            return
        }
        guard let user = userRepository.user else {
            alert = .error(.noUserError)
            return
        }
        guard sessionValidator.isAuthenticated else {
            alert = .error(.noUserError)
            return
        }
        let order = Order(
            id: UUID().uuidString,
            customerName: user.name,
            customerAdress: user.address,
            customerMobile: user.mobile,
            items: basketState.items,
            orderTotal: basketState.totalPrice
        )
        Task {
            try await drinkRepository.placeOrder(order: order)
        }
        basketState.items = []
    }
}
