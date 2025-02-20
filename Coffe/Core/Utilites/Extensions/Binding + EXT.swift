//
//  Binding + EXT.swift
//  Coffe
//
//  Created by macbook on 30.01.2025.
//
import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
extension Binding {
    static func twoWay<T>(
        _ keyPath: ReferenceWritableKeyPath<T, Value>,
        on object: T
    ) -> Binding<Value> where T: Observable {
        return Binding(
            get: { object[keyPath: keyPath] },
            set: { object[keyPath: keyPath] = $0 }
        )
    }
}
