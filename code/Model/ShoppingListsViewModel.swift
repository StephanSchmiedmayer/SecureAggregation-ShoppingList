//
//  ShoppingListsViewModel.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import Foundation

class ShoppingListsViewModel: ObservableObject {
    @Published public private(set) var lists: [ShoppingList]
    
    init() {
        lists = [
            ShoppingList(name: "Rewe", elements: [
                ShoppingListElement(done: false, text: "Tomaten 25g"),
                ShoppingListElement(done: false, text: "Bier"),
                ShoppingListElement(done: true, text: "Eier"),
                ShoppingListElement(done: true, text: "Philadelphia"),
                ShoppingListElement(done: true, text: "Appenzeller"),
                ShoppingListElement(done: true, text: "MilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilchMilch"),

            ]),
            ShoppingList(name: "Kaufland", elements: [
                ShoppingListElement(done: false, text: "Eier"),
                ShoppingListElement(done: false, text: "Bananen"),
                ShoppingListElement(done: true, text: "Milch"),
            ]),
        ]
    }
    
    // TODO: make thread-safe
    /**
     Returns list with the specified id
     */
    func list(withID listID: ShoppingList.ID) -> ShoppingList? {
        return lists.first(where: { $0.id == listID })
    }
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
        lists = lists.filter{$0.id != list.id}
    }
    
    func renameList(_ list: ShoppingList, to newName: String) {
        guard let listIndex = lists.firstIndex(matchingIdOf: list) else { return }
        lists[listIndex].changeName(to: newName)
    }
    
    /**
     Toggles done of the `ShoppingListElement`in the given `ShoppingList`
     */
    func toggleDone(of element: ShoppingListElement, inList list: ShoppingList) {
        guard let listIndex = lists.firstIndex(matchingIdOf: list),
              let elementIndex = lists[listIndex].elements.firstIndex(matchingIdOf: element) else { return }
        lists[listIndex].elements[elementIndex].toggleDone()
    }
    
    /**
     Adds a new `ShoppingListElement` with the given name to the specified `ShoppingList`
     */
    func addElement(_ elementName: String, toList list: ShoppingList) {
        addElement(ShoppingListElement(done: false, text: elementName), toList: list)
    }
    
    /**
     Adds the `ShoppingListElement` to the specified `ShoppingList`
     */
    func addElement(_ element: ShoppingListElement, toList list: ShoppingList) {
        guard let listIndex = lists.firstIndex(matchingIdOf: list) else { return }
        lists[listIndex].addElement(element)
    }
}
