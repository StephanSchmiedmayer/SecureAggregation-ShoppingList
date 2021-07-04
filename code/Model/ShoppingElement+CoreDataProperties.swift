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
    
    convenience init(context: NSManagedObjectContext, id: UUID = UUID(), text: String) {
        self.init(context: context)
        self.id = id
        self.text = text
    }
    
    /// Copy constructor. Creates a new id
    convenience init(_ toCopy: ShoppingElement) {
        if let context = toCopy.managedObjectContext {
            self.init(context: context)
        } else {
            print("Warning: ShoppingElement to copy had no managedObjectContext")
            self.init()
        }
        self.id = UUID()
        self.text = toCopy.text
    }
}

extension ShoppingElement: Identifiable { }
