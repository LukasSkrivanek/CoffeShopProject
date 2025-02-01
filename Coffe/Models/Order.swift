//
//  Order.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation

struct Order: Codable{
let id: String
let customerName: String
let customerAdress: String
let customerMobile: String
let items: [Drink]
let orderTotal: Double
}
