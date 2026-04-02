//
//  AppError.swift
//  CoffeCore
//

import Foundation

public enum AppError: Equatable {
    case emptyBasketError
    case noUserError
}

extension AppError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .emptyBasketError:
            return "You have no items in your basket."
        case .noUserError:
            return "Please login to place an order"
        }
    }
}
