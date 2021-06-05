//
//  Array+Identifiable.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 04.06.21.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matchingIdOf element: Element) -> Int? {
        return self.firstIndex(where: { $0.id == element.id})
    }
}
