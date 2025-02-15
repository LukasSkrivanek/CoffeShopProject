//
//  AppError.swift
//  Coffe
//
//  Created by macbook on 28.02.2024.
//

import Foundation

enum AppError {
    case emptyBasketError, noUserError
}

extension AppError: CustomStringConvertible{
    public var description: String {
        switch self {
        case .emptyBasketError:
            return "You have no items in your basket."
        case .noUserError:
            return "Please login to place an order"
        }
    }
}
