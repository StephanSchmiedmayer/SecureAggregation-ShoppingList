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
                    if let listID = list.id,
                       let name = list.name,
                       let uncheckedElements = list.uncheckedElements?.array as? [ShoppingElement] {
                        NavigationLink(destination: ListView(listID: listID)) {
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
    
//    private var settings: some View {
//        Menu {
//            Button {
//
//            }, label: {
//                Label(
//                    title: { Text("") },
//                    icon: { Image(systemName: "42.circle") }
//                )
//            }
//        }
}


struct ListsOverview_Previews: PreviewProvider {
    static var previews: some View {
        ListsOverview()
            .environment(\.managedObjectContext, ShoppingListsViewModel.preview.container.viewContext)
            .environmentObject(ShoppingListsViewModel.preview)
    }
}
