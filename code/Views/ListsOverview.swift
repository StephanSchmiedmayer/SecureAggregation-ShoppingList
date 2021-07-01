//
//  ListsOverview.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI
import SecureAggregationClient
import CoreData

struct ListsOverview: View {
    @EnvironmentObject private var viewModel: ShoppingListsViewModel
    
    @FetchRequest(entity: ShoppingList.entity(), sortDescriptors: [])
    private var lists: FetchedResults<ShoppingList>
    
    @State private var showAddListSheet = false
    @State private var addListName = ""
        
    var body: some View {
        // TODO: scrollview + navigation title scoll animation bug: https://stackoverflow.com/questions/64280447/scrollview-navigationview-animation-glitch-swiftui
        NavigationView {
            ScrollView {
                // Needed bc of NavigationLink bug (https://developer.apple.com/forums/thread/677333):
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                ForEach(lists, id: \.id) { list in
                    if let listID = list.id {
                        NavigationLink(destination: ListView(list: list)) {
                            ListOverviewCard(list: list)
                        }
                    }
                }
                if lists.isEmpty {
                    HStack {
                        Spacer()
                        Text("Protip: create a list")
                        Spacer()
                    }
                }
            }
            .background(Color.backgroundColor.ignoresSafeArea())
            .sheet(isPresented: $showAddListSheet, content: {
                NavigationView {
                    Form {
                        TextField("Name", text: $addListName)
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

/// Needed because else a change of the list would pop the ListView (idk why, maybe SwiftUI bug, maybe intentional)
struct ListOverviewCard: View {
    @StateObject var list: ShoppingList
    
    var body: some View {
        if let name = list.name,
           let uncheckedElements = list.uncheckedElements?.array as? [ShoppingElement] {
            CardView(title: name,
                     isNavigationLink: true) {
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
        } else {
            // Shows during deletion:
            EmptyView()
        }
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
