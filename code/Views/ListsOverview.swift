//
//  ListsOverview.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI
import SecureAggregationClient
import CoreData
import SwiftUIX
import EyeKit

struct ListsOverview: View {
    @EnvironmentObject private var viewModel: ShoppingListsViewModel
    
    @FetchRequest(fetchRequest: ShoppingListsViewModel.listsFetchRequest())
    private var lists: FetchedResults<ShoppingList>
    
    @State private var showAddListSheet = false
    @State private var addListName = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(lists) { list in
                    if let name = list.name,
                       let uncheckedElements = list.uncheckedElements {
                        NavigationLink(destination: ListView(list: list)) {
                            VStack(spacing: 0) {
                                HStack {
                                    Text(name)
                                        .headline()
                                    Spacer()
                                }
                                if !uncheckedElements.isEmpty {
                                    HStack {
                                        Text("\(uncheckedElements.compactMap { $0.text }.joined(separator: ", "))")
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(1)
                                            .foregroundColor(.secondaryTextColor)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
                if lists.isEmpty {
                    Text("Protip: create a list")
                }
            }
            .background(Color.backgroundColor.ignoresSafeArea())
            .sheet(isPresented: $showAddListSheet, content: {
                NavigationView {
                    Form {
                        CocoaTextField("Name", text: $addListName)
                            .isFirstResponder(true)
                    }
                    // TODO: add note about already taken list name
                    .navigationTitle("Add a new List")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarItems(leading: cancelButtonInsideSheet, trailing: addButtonInsideSheet)
                }
            })
            .navigationBarItems(trailing: showAddListSheetButton)
            .navigationTitle("Your shopping lists")
            .navigationBarTitleDisplayMode(.large)
        }
        .environmentObject(viewModel)
    }
    
    private var showAddListSheetButton: some View {
        Button {
            showAddListSheet = true
        } label: {
            Image(systemName: "plus")
                .font(Font.system(size: 20))
        }
    }
    
    private var addButtonInsideSheet: some View {
        Button(action: {
            viewModel.addList(name: addListName)
            closeSheet()
        }, label: {
            Text("Add")
                .bold()
        })
        .disabled(addListName.isEmpty || listNameExistent)
    }
    
    private var cancelButtonInsideSheet: some View {
        Button(action: closeSheet, label: {
            Text("Cancel")
                .fontWeight(.regular)
        })
    }
    
    /// True if the name entered in addListName already exists
    private var listNameExistent: Bool {
        lists.contains(where: { $0.name == addListName })
    }
    
    /// Closes the sheet and resets all Parameters entered
    private func closeSheet() {
        addListName = ""
        showAddListSheet = false
    }
}

struct ListsOverview_Previews: PreviewProvider {
    static var previews: some View {
        let preview = ShoppingListsViewModel.preview
        ListsOverview()
            .environment(\.managedObjectContext, preview.container.viewContext)
            .environmentObject(preview)
    }
}
