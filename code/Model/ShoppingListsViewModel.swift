//
//  ShoppingListsViewModel.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import Foundation

class ShoppingListsViewModel: ObservableObject {
    @Published private(set) var lists: [ShoppingList]
    
    init() {
        lists = [
            ShoppingList(name: "Rewe", elements: [
                ShoppingListElement(checked: false, text: "Tomaten 25g"),
                ShoppingListElement(checked: false, text: "Bier"),
                ShoppingListElement(checked: true, text: "Eier"),
                ShoppingListElement(checked: true, text: "Philadelphia"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "MilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilch"),
            ]),
            ShoppingList(name: "Lidl", elements: [
                ShoppingListElement(checked: false, text: "Tomaten 25g"),
                ShoppingListElement(checked: false, text: "Bier"),
                ShoppingListElement(checked: true, text: "Eier"),
                ShoppingListElement(checked: true, text: "Philadelphia"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "MilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilch"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "Appenzeller"),
                ShoppingListElement(checked: true, text: "So much Appenzeller"),
            ]),
            ShoppingList(name: "Kaufland", elements: [
                ShoppingListElement(checked: false, text: "Eier"),
                ShoppingListElement(checked: false, text: "Bananen"),
                ShoppingListElement(checked: true, text: "Milch"),
            ]),
        ]
    }
    
    // TODO: make thread-safe
    /**
     Returns list with the specified id
     */
    func list(withID listID: ShoppingList.ID) -> ShoppingList? {
        lists.first(where: { $0.id == listID })
    }
    
    // MARK: - Mutating access to lists
    /**
     Adds a `ShoppingList` to the end of `lists`
     */
    func addList(_ list: ShoppingList) {
        lists.append(list)
    }
    
    /**
     Removes all `ShoppingList`s with the same id
     */
    func removeList(_ list: ShoppingList) {
        lists = lists.filter { $0.id != list.id }
    }
    
    func renameList(_ list: ShoppingList, to newName: String) {
        guard let listIndex = lists.firstIndex(matchingIdOf: list) else { return }
        lists[listIndex].changeName(to: newName)
    }
    
    /**
     Adds a new `ShoppingListElement` with the given name to the specified `ShoppingList`
     */
    func addElement(_ elementName: String, toList list: ShoppingList) {
        addElement(ShoppingListElement(checked: false, text: elementName), toList: list)
    }
    
    /**
     Adds the `ShoppingListElement` to the specified `ShoppingList`
     */
    func addElement(_ element: ShoppingListElement, toList list: ShoppingList) {
        guard let listIndex = lists.firstIndex(matchingIdOf: list) else { return }
        lists[listIndex].addElement(element)
    }
    
    func toggleShowCheckedElements(of list: ShoppingList) {
        guard let listIndex = lists.firstIndex(matchingIdOf: list) else { return }
        lists[listIndex].showCheckedElements.toggle()
    }
    
    // MARK: - Mutating access to elements
    /**
     Toggles checked of the `ShoppingListElement`in the given `ShoppingList`
     */
    func toggleChecked(of element: ShoppingListElement, inList list: ShoppingList) {
        guard let listIndex = lists.firstIndex(matchingIdOf: list) else { return }
        lists[listIndex].toggleCheckedOfElement(element)
    }
}
