//
//  ListView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI
import IrregularGradient

struct ListView: View {
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    let listID: ShoppingList.ID
    
    /// List corresponding to listID. Optional because otherwise when the list gets deleted while this view is shown an IndexOutOfBounds Error is thrown
    var optionalList: ShoppingList? {
        viewModel.list(withID: listID)
    }
    
    @State private var addElementText = ""
    
    
    init(listID: ShoppingList.ID) {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        self.listID = listID
    }
    
    var body: some View {
        if let list = optionalList {
            List {
                ForEach(list.elements) { element in
                    VStack(spacing: 0) {
                        ListElementView(list: list, element: element)
                    }
                }
                .listRowBackground(BlurredBackground())
                Button(action: { viewModel.removeList(list)}, label: {
                    Text("Delete List")
                })
                .listRowBackground(BlurredBackground())
            }
            .listStyle(SidebarListStyle())
//            .padding(.bottom, 25) // TODO: bessere lösung damit kein Element verdeckt wird bei einer langen Liste ganz unten
            .overlay(AddTextFieldView(textFieldDefaultText: "Add new element") { input in
                viewModel.addElement(input, toList: list)
            }, alignment: .bottom)
            .background(BackgroundView())
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
            .navigationTitle(list.name)
        }
        else {
            Text("List has been deleted")
        }
    }
    
    private func addElement(toList list: ShoppingList) {
        guard addElementText != "" else { return }
        viewModel.addElement(addElementText, toList: list)
        addElementText = ""
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            PreviewWrapper()
                .preferredColorScheme(scheme)
        }
    }
    
    struct PreviewWrapper: View {
        @StateObject var viewModel = ShoppingListsViewModel()
        
        var body: some View {
            NavigationView {
                ListView(listID: viewModel.lists[0].id)
                    .environmentObject(viewModel)
            }
        }
    }
}
