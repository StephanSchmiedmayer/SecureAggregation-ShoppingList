//
//  ShoppingList+CoreDataProperties.swift
//  shoppingList
//
//  Created by stephan on 04.07.21.
//
//  swiftlint:disable discouraged_optional_collection

import Foundation
import CoreData


extension ShoppingList {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<ShoppingList> {
        NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var showCheckedElements: Bool
    @NSManaged public var elements: NSOrderedSet?
    
    public var elementsArray: [ShoppingElement]? {
        elements?.array as? [ShoppingElement]
    }
    
    var checkedElements: [ShoppingElement]? {
        elementsArray?.filter { $0.checked }
    }
    
    var uncheckedElements: [ShoppingElement]? {
        elementsArray?.filter { !$0.checked }
    }
    
    convenience init(context: NSManagedObjectContext,
                     id: UUID = UUID(),
                     name: String,
                     showCheckedElements: Bool = false,
                     elements: [ShoppingElement] = []) {
        self.init(context: context)
        self.id = id
        self.name = name
        self.showCheckedElements = showCheckedElements
        for element in elements {
            self.addToElements(element)
        }
    }
}

// MARK: Generated accessors for elements
extension ShoppingList {
    @objc(insertObject:inElementsAtIndex:)
    @NSManaged public func insertIntoElements(_ value: ShoppingElement, at idx: Int)

    @objc(removeObjectFromElementsAtIndex:)
    @NSManaged public func removeFromElements(at idx: Int)

    @objc(insertElements:atIndexes:)
    @NSManaged public func insertIntoElements(_ values: [ShoppingElement], at indexes: NSIndexSet)

    @objc(removeElementsAtIndexes:)
    @NSManaged public func removeFromElements(at indexes: NSIndexSet)

    @objc(replaceObjectInElementsAtIndex:withObject:)
    @NSManaged public func replaceElements(at idx: Int, with value: ShoppingElement)

    @objc(replaceElementsAtIndexes:withElements:)
    @NSManaged public func replaceElements(at indexes: NSIndexSet, with values: [ShoppingElement])

    @objc(addElementsObject:)
    @NSManaged public func addToElements(_ value: ShoppingElement)

    @objc(removeElementsObject:)
    @NSManaged public func removeFromElements(_ value: ShoppingElement)

    @objc(addElements:)
    @NSManaged public func addToElements(_ values: NSOrderedSet)

    @objc(removeElements:)
    @NSManaged public func removeFromElements(_ values: NSOrderedSet)
}

extension ShoppingList: Identifiable { }
