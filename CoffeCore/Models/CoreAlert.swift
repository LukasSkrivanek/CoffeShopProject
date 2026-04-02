//
//  CoreAlert.swift
//  CoffeCore
//

import Foundation

public struct CoreAlert: Sendable, Equatable {

    public enum Action: String, Sendable, CaseIterable {
        case ok
        case confirm
        case cancel
    }

    public let title: String
    public let subtitle: String?
    public let actions: [Action]

    public init(title: String, subtitle: String? = nil, actions: [Action] = [.ok]) {
        self.title = title
        self.subtitle = subtitle
        self.actions = actions
    }

    public static func error(_ error: AppError) -> CoreAlert {
        CoreAlert(title: "Error", subtitle: error.description)
    }
}
