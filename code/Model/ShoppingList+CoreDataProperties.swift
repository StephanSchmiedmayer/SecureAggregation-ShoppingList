//
//  ShoppingList+CoreDataProperties.swift
//  shoppingList
//
//  Created by stephan on 04.07.21.
//
// swiftlint:disable discouraged_optional_collection

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
    @NSManaged public var checkedElements: NSOrderedSet?
    @NSManaged public var uncheckedElements: NSOrderedSet?
    
    public var checkElementsArray: [ShoppingElement]? {
        checkedElements?.array as? [ShoppingElement]
    }
    
    public var uncheckElementsArray: [ShoppingElement]? {
        uncheckedElements?.array as? [ShoppingElement]
    }
}

// MARK: Generated accessors for checkedElements
extension ShoppingList {
    @objc(insertObject:inCheckedElementsAtIndex:)
    @NSManaged public func insertIntoCheckedElements(_ value: ShoppingElement, at idx: Int)

    @objc(removeObjectFromCheckedElementsAtIndex:)
    @NSManaged public func removeFromCheckedElements(at idx: Int)

    @objc(insertCheckedElements:atIndexes:)
    @NSManaged public func insertIntoCheckedElements(_ values: [ShoppingElement], at indexes: NSIndexSet)

    @objc(removeCheckedElementsAtIndexes:)
    @NSManaged public func removeFromCheckedElements(at indexes: NSIndexSet)

    @objc(replaceObjectInCheckedElementsAtIndex:withObject:)
    @NSManaged public func replaceCheckedElements(at idx: Int, with value: ShoppingElement)

    @objc(replaceCheckedElementsAtIndexes:withCheckedElements:)
    @NSManaged public func replaceCheckedElements(at indexes: NSIndexSet, with values: [ShoppingElement])

    @objc(addCheckedElementsObject:)
    @NSManaged public func addToCheckedElements(_ value: ShoppingElement)

    @objc(removeCheckedElementsObject:)
    @NSManaged public func removeFromCheckedElements(_ value: ShoppingElement)

    @objc(addCheckedElements:)
    @NSManaged public func addToCheckedElements(_ values: NSOrderedSet)

    @objc(removeCheckedElements:)
    @NSManaged public func removeFromCheckedElements(_ values: NSOrderedSet)
}

// MARK: Generated accessors for uncheckedElements
extension ShoppingList {
    @objc(insertObject:inUncheckedElementsAtIndex:)
    @NSManaged public func insertIntoUncheckedElements(_ value: ShoppingElement, at idx: Int)

    @objc(removeObjectFromUncheckedElementsAtIndex:)
    @NSManaged public func removeFromUncheckedElements(at idx: Int)

    @objc(insertUncheckedElements:atIndexes:)
    @NSManaged public func insertIntoUncheckedElements(_ values: [ShoppingElement], at indexes: NSIndexSet)

    @objc(removeUncheckedElementsAtIndexes:)
    @NSManaged public func removeFromUncheckedElements(at indexes: NSIndexSet)

    @objc(replaceObjectInUncheckedElementsAtIndex:withObject:)
    @NSManaged public func replaceUncheckedElements(at idx: Int, with value: ShoppingElement)

    @objc(replaceUncheckedElementsAtIndexes:withUncheckedElements:)
    @NSManaged public func replaceUncheckedElements(at indexes: NSIndexSet, with values: [ShoppingElement])

    @objc(addUncheckedElementsObject:)
    @NSManaged public func addToUncheckedElements(_ value: ShoppingElement)

    @objc(removeUncheckedElementsObject:)
    @NSManaged public func removeFromUncheckedElements(_ value: ShoppingElement)

    @objc(addUncheckedElements:)
    @NSManaged public func addToUncheckedElements(_ values: NSOrderedSet)

    @objc(removeUncheckedElements:)
    @NSManaged public func removeFromUncheckedElements(_ values: NSOrderedSet)
}

extension ShoppingList: Identifiable { }
