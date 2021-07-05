//
//  shoppingListApp.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 20.05.21.
//

import SwiftUI
/* TODO :
 - swiftlint rules überarbeiten
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
