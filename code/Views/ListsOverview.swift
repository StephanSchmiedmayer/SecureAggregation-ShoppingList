//
//  ListsOverview.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI

struct ListsOverview: View {
    @StateObject var viewModel: ShoppingListsViewModel = ShoppingListsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.lists, id: \.id) { list in
                    NavigationLink(destination: ListView(listID: list.id)) {
                        ListOverviewCard(listID: list.id)
                    }
                }
                // TODO: anders gestalten, sieht aus wie Liste
                CardView(title: "Add new List", isNavigationLink: false) {
                    AddTextFieldView(textFieldDefaultText: "List Name") { input in
                        viewModel.addList(ShoppingList(name: input, elements: []))
                    }
                }
            }
            .navigationTitle("Your shopping lists")
            .background(BackgroundView())
        }
        .environmentObject(viewModel)
    }
}

struct ListOverviewCard: View {
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    let listID: ShoppingList.ID
    
    var optionalList: ShoppingList? {
        viewModel.list(withID: listID)
    }
    
    var body: some View {
        if let list = optionalList {
            CardView(title: list.name,
                     isNavigationLink: true) {
                HStack {
                    Text("\(list.elements.compactMap{ $0.text }.joined(separator: ", "))")
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .foregroundColor(.secondaryTextColor)
                    Spacer()
                }
            }
        } else {
            Text("List deleted")
        }
    }
}

struct ListsOverview_Previews: PreviewProvider {
    static var previews: some View {
        ListsOverview()
    }
}
