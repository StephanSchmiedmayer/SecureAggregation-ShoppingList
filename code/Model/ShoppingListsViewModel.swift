//
//  ShoppingListsViewModel.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import Foundation
import CoreData

class ShoppingListsViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    private var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    static var preview: ShoppingListsViewModel = {
        let result = ShoppingListsViewModel(inMemory: true)
        let viewContext = result.container.viewContext
        let newList = ShoppingList(context: viewContext,
                                   // swiftlint:disable:next force_unwrapping
                                   id: UUID(uuidString: "8C97824E-E975-490B-B76B-FDBD4070F512")!,
                                   name: "TestList",
                                   showCheckedElements: true,
                                   elements: [
                                    ShoppingElement(context: viewContext, id: UUID(), text: "Test", checked: false)
                                   ])
        let secondNewList = ShoppingList(context: viewContext,
                                         id: UUID(),
                                         name: "SecondTestList",
                                         showCheckedElements: true,
                                         elements: [
                                          ShoppingElement(context: viewContext, id: UUID(), text: "Testtest", checked: false)
                                         ])
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ShoppingListsModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _ /*storeDescription*/, error in
            if let error = error as NSError? {
                // TODO: Replace this implementation with code to handle the error appropriately.
                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // TODO: handle error
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - FetchRequests
    
    /**
     Generic fetchrequest to get all ShoppingLists from CoreData
     */
    static func listsFetchRequest() -> NSFetchRequest<ShoppingList> {
        let result = NSFetchRequest<ShoppingList>(entityName: Constant.CoreData.listName)
        result.sortDescriptors = []
        return result
    }
    
    // MARK: - Mutating access to persistent storage
    /**
     Adds a `ShoppingList` to the end of `lists`
     */
    func addList(name: String) {
        _ = ShoppingList(context: viewContext, name: name)
        saveContext()
    }
    
    /**
     Removes all `ShoppingList`s with the same id
     */
    func removeList(_ list: ShoppingList) {
        container.viewContext.delete(list)
        saveContext()
    }
    
    func renameList(_ list: ShoppingList, to newName: String) {
        list.name = newName
        saveContext()
    }
    
    /**
     Adds a new `ShoppingListElement` with the given text to the specified `ShoppingList`
     */
    func addElement(text: String, toList list: ShoppingList) {
        list.addToElements(ShoppingElement(context: viewContext, text: text))
        saveContext()
    }
    
    func removeElement(_ element: ShoppingElement) {
        container.viewContext.delete(element)
        saveContext()
    }
    
    func toggleShowCheckedElements(of list: ShoppingList) {
        list.showCheckedElements.toggle()
        saveContext()
    }
    
    // MARK: - Mutating access to elements
    
    func changeTextOf(element: ShoppingElement, to newText: String) {
        element.text = newText
        saveContext()
    }
    
    /**
     Toggles checked of the `ShoppingListElement`in the given `ShoppingList`
     */
    func toggleChecked(of element: ShoppingElement) {
        element.checked.toggle()
        saveContext()
        element.list?.objectWillChange.send() // TODO: See ShoppingElement+CoreDataProperties.swift
    }
}
