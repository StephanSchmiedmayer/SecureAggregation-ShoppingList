//
//  ShoppingLists.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import Foundation

struct ShoppingList: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var elements: [ShoppingListElement]
    
    /**
     Changes the name of the `ShoppingList`
     */
    mutating func changeName(to newName: String) {
        self.name = newName
    }
    
    /**
     Adds the element to the end of `elements`
     */
    mutating func addElement(_ element: ShoppingListElement) {
        elements.append(element)
    }
    
    /**
     Removes all `ShoppingListElement`s with the same id
     */
    mutating func removeElement(_ element: ShoppingListElement) {
        elements = elements.filter { $0.id != element.id}
    }
}

//extension ShoppingList: Equatable {
//    static func == (lhs: ShoppingList, rhs: ShoppingList) -> Bool {
//        lhs.id == rhs.id
//    }
//}

struct ShoppingListElement: Identifiable, Equatable {
    let id = UUID()
    var done: Bool = false
    var text: String
    
    /**
     Toggles `done`
     */
    mutating func toggleDone() {
        self.done.toggle()
    }
    
    /**
     Changes the text of the `ShoppingListElement`
     */
    mutating func changeText(to newText: String) {
        self.text = newText
    }
}

//extension ShoppingListElement: Equatable {
//    static func == (lhs: ShoppingListElement, rhs: ShoppingListElement) -> Bool {
//        lhs.id == rhs.id
//    }
//}
