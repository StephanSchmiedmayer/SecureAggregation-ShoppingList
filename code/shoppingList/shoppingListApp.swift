//
//  shoppingListApp.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 20.05.21.
//

import SwiftUI
/* TODO :
 - set right app id
 - swiftlint rules überarbeiten
 - CoreData model files generieren:
    - construktor direkt mit members
    - NSOrderedSet zu Array
    - Identifiable
 - Ordering Lists after creation different when restarting app
 */
@main
struct ShoppingListApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
