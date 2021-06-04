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
            List {
                ForEach(viewModel.lists, id: \.id) { list in
                    NavigationLink(destination: ListView(list: list)) {
                        ListOverviewCard(list: list)
                    }
                }
            }
            .navigationTitle("Your shopping lists")
            .listStyle(DefaultListStyle())
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .environmentObject(viewModel)
    }
}

struct ListOverviewCard: View {
    let list: ShoppingList
    
    var body: some View {
        VStack {
            HStack {
                Text(list.name)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("\(list.elements.compactMap{ $0.text }.joined(separator: ", "))")
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundColor(.secondaryTextColor)
                Spacer()
            }
            .padding(.top, 5)
            Text("\(list.id)")
            Text("\(list.elements[0].done.description)")
        }
        .padding()
        .background(Color.foregroundColor)
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal)
        .padding(.vertical, 5)

    }
}

struct ListsOverview_Previews: PreviewProvider {
    static var previews: some View {
        ListsOverview()
    }
}
