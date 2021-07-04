//
//  ShoppingElement+CoreDataProperties.swift
//  shoppingList
//
//  Created by stephan on 04.07.21.
//
//

import Foundation
import CoreData


extension ShoppingElement {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<ShoppingElement> {
        NSFetchRequest<ShoppingElement>(entityName: "ShoppingElement")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var checked: Bool
    @NSManaged public var list: ShoppingList?
    
    convenience init(context: NSManagedObjectContext,
                     id: UUID = UUID(),
                     text: String,
                     checked: Bool = false) {
        self.init(context: context)
        self.id = id
        self.text = text
        self.checked = checked
        self.list = list
    }
}

extension ShoppingElement: Identifiable { }
