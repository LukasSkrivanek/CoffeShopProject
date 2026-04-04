//
//  CoreAlert.swift
//  CoffeCore
//

import Foundation

public struct CoreAlert: Sendable, Equatable {
    public let title: String
    public let subtitle: String?

    public init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    public static func error(_ error: AppError) -> CoreAlert {
        CoreAlert(title: "Error", subtitle: error.description)
    }
}
