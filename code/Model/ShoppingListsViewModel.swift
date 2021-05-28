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
            ShoppingList(name: "Nahrungsmittel", elements: [
                ShoppingListElement(done: false, text: "Eier"),
                ShoppingListElement(done: false, text: "Bananen"),
                ShoppingListElement(done: true, text: "Milch"),
            ]),
            ShoppingList(name: "GanzWildeListeHuiuiuiuiui", elements: [
                ShoppingListElement(done: false, text: "Eier"),
                ShoppingListElement(done: false, text: "Bananen"),
                ShoppingListElement(done: true, text: "Milch"),
            ]),
            ShoppingList(name: "Nope", elements: [
                ShoppingListElement(done: false, text: "Eier"),
                ShoppingListElement(done: false, text: "Bananen"),
                ShoppingListElement(done: true, text: "Milch"),
            ])
        ]
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
    
    /**
     Toggles done of the `ShoppingListElement`in the given `ShoppingList`
     */
    func toggleDone(of element: ShoppingListElement, inList list: ShoppingList) {
        guard let listIndex = lists.firstIndex(of: list),
              let elementIndex = lists[listIndex].elements.firstIndex(of: element) else {
            return
        }
        lists[listIndex].elements[elementIndex].toggleDone()
    }
    
    /**
     Adds the `ShoppingListElement` to the specified `ShoppingList`
     */
    func addElement(_ element: ShoppingListElement, toList list: ShoppingList) {
        guard let listIndex = lists.firstIndex(of: list) else {
            return
        }
        lists[listIndex].addElement(element)
    }
}
