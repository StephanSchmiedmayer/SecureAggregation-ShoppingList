//
//  NSOrderedSet+Array.swift
//  shoppingList
//
//  Created by stephan on 04.07.21.
// swiftlint:disable discouraged_optional_collection

import Foundation

extension NSOrderedSet {
    func toArray<T>() -> [T]? {
        self.array as? [T]
    }
}
