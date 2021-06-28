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
    
    init() {
        UIScrollView.appearance().backgroundColor = UIColor(Color.backgroundColor)
    }
    
    var body: some View {
        // TODO: scrollview + navigation title scoll animation bug: https://stackoverflow.com/questions/64280447/scrollview-navigationview-animation-glitch-swiftui
        NavigationView {
            ScrollView {
                ForEach(lists, id: \.id) { list in
                    if let listID = list.id {
                        NavigationLink(destination: ListView(listID: listID)) {
                            ListOverviewCard(listID: listID)
                        }
                    }
                }
                // "Spacer" for overlay:
                AddTextFieldView(textFieldDefaultText: "", processFinishedInput: { _ in })
                    .hidden()
            }
            .overlay(AddTextFieldView(textFieldDefaultText: "List Name") { input in
                viewModel.addList(name: input)
            }, alignment: .bottom)
            .navigationTitle("Your shopping lists")
            .navigationBarTitleDisplayMode(.large)
        }
        .environmentObject(viewModel)
    }
    
    struct ListOverviewCard: View {
        // TODO: update with new Core-data classes
        let listID: UUID
        
        @FetchRequest(entity: ShoppingList.entity(), sortDescriptors: [])
        private var lists: FetchedResults<ShoppingList>
        
        var optionalList: ShoppingList? {
            lists.first(where: { $0.id == listID })
        }
        
        init(listID: UUID) {
            self.listID = listID
        }
        
        var body: some View {
            if let list = optionalList,
               let name = list.name,
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
}


struct ListsOverview_Previews: PreviewProvider {
    static var previews: some View {
        ListsOverview()
            .environmentObject(ShoppingListsViewModel.preview)
            .environment(\.managedObjectContext, ShoppingListsViewModel.preview.container.viewContext)
    }
}
