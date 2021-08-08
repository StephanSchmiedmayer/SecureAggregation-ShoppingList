//
//  AppState.swift
//  shoppingList
//
//  Created by stephan on 04.08.21.
//

import SwiftUI

var config = AppState()

/// Visual state of the App
struct AppState {
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: LastAction
    var lastAction: LastAction = .none
    
    // MARK: List (Elements)
    // Visual characteristics of the actual ListElements, "Add New Element" TextField and exit-Label
    var listFontSize: CGFloat = 30
    var listTextColor = Color("TextColor")
    var listCheckedTextColor = Color("SecondaryTextColor")
    var listBackgroundColor = Color("ListBackgroundColor") // TODO
    
    // MARK: Settings
    // TODO
    var settingsFontSize: CGFloat = 20
    var settingsTextColor = Color("TextColor")
    
    // MARK: - Initializer
    /// AppState cannot be created outside this class, ensure only config is used
    fileprivate init() {}
    
    // MARK: - Update AppState
    mutating func updateLastAction(to action: LastAction) {
        print("newLastAction: \(action)")
        lastAction = action
    }
    
    /// Returns a **copy** of the current AppState
    func getCurrentConfiguration() -> AppState {
        self
    }
}

/// Actions the user can do
enum LastAction {
    /// No previous Action (just opened the App)
    case none
    
    /// Shopping List:
    case openedList, closedList
    case checkedElement, uncheckedElement
    case beganEditElement, closedEditElement
    // State transitions: beganAddNewElement, (addedNewElement)*, closedAddNewElement
    case beganAddNewElement, addedNewElement, closedAddNewElement
    
//    /// User pressed anything related to settings (e.g.
//    case settings
}
