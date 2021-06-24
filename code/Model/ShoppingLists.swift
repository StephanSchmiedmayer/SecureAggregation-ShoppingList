//
//  ShoppingLists.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import Foundation
/*
@available(*, deprecated, message: "Not persistent, use persistent storage")
struct ShoppingList: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var showCheckedElements = false
    private(set) var notCheckedElements: [ShoppingListElement]
    private(set) var checkedElements: [ShoppingListElement]
    
    init(name: String, elements: [ShoppingListElement]) {
        self.name = name
        notCheckedElements = elements.filter { !$0.checked }
        checkedElements = elements.filter { $0.checked }
    }
    
    // MARK: - mutating functions
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
        if element.checked {
            checkedElements.append(element)
        } else {
            notCheckedElements.append(element)
        }
    }
    
    /**
     Removes all `ShoppingListElement`s with the same id
     */
    mutating func removeElement(_ element: ShoppingListElement) {
        if checkedElements.contains(where: { $0.id == element.id }) {
            checkedElements = checkedElements.filter { $0.id != element.id }
        } else {
            notCheckedElements = notCheckedElements.filter { $0.id != element.id }
        }
    }
    
    /**
     Toggles checked of the `ShoppingListElement` and updates notCheckedElements and checkedElements accordingly
     */
    mutating func toggleCheckedOfElement(_ element: ShoppingListElement) {
        if let checkedElementsIndex = checkedElements.firstIndex(matchingIdOf: element) {
            var elementToToggle = checkedElements.remove(at: checkedElementsIndex)
            elementToToggle.toggleChecked()
            notCheckedElements.append(elementToToggle)
        } else if let notCheckedElementsIndex = notCheckedElements.firstIndex(matchingIdOf: element) {
            var elementToToggle = notCheckedElements.remove(at: notCheckedElementsIndex)
            elementToToggle.toggleChecked()
            checkedElements.insert(elementToToggle, at: 0)
        }
    }
}

@available(*, deprecated, message: "Not persistent, use persistent storage")
struct ShoppingListElement: Identifiable, Equatable {
    let id = UUID()
    // TODO: delete checked from shoppingListElement to remove the possibility of undefined states
    var checked = false
    var text: String
    
    /**
     Changes the text of the `ShoppingListElement`
     */
    mutating func changeText(to newText: String) {
        self.text = newText
    }
    
    mutating func toggleChecked() {
        self.checked.toggle()
    }
}
*/
