//
//  ListsOverview.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI

struct ListsOverview: View {
    @StateObject private var viewModel: ShoppingListsViewModel = ShoppingListsViewModel()
//    @StateObject private var navigationTitleBarBug: Bool = false
    
    init() {
        UIScrollView.appearance().layer.insertSublayer(BackgroundView().uiKit(), at: 0)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.lists, id: \.id) { list in
                    NavigationLink(destination: ListView(listID: list.id)) {
                        ListOverviewCard(listID: list.id)
                    }
                }
                AddTextFieldView(textFieldDefaultText: "", processFinishedInput: {_ in })
                    .hidden()
            }
            .overlay(AddTextFieldView(textFieldDefaultText: "List Name") { input in
                viewModel.addList(ShoppingList(name: input, elements: []))
            }, alignment: .bottom)
            .navigationTitle("Your shopping lists")
            .navigationBarTitleDisplayMode(.large)
            // TODO: Bug: nach TextField geöffnet spackt NavigationTitle rum wenn man so den background setzt (auch ListView)
            .background(BackgroundView())
            .navigationViewStyle(StackNavigationViewStyle())
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
                if !list.notCheckedElements.isEmpty {
                    HStack {
                        Text("\(list.notCheckedElements.compactMap{ $0.text }.joined(separator: ", "))")
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .foregroundColor(.secondaryTextColor)
                        Spacer()
                    }
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
