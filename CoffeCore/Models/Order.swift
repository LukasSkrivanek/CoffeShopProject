//
//  Order.swift
//  CoffeCore
//

import Foundation

public struct Order: Codable {
    public let id: String
    public let customerName: String
    public let customerAdress: String
    public let customerMobile: String
    public let items: [Drink]
    public let orderTotal: Double

    public init(id: String, customerName: String, customerAdress: String, customerMobile: String, items: [Drink], orderTotal: Double) {
        self.id = id
        self.customerName = customerName
        self.customerAdress = customerAdress
        self.customerMobile = customerMobile
        self.items = items
        self.orderTotal = orderTotal
    }
}
