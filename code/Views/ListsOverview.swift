//
//  ListsOverview.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI

struct ListsOverview: View {
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    
    var body: some View {
        ScrollView {
            forEach(data: viewModel.lists) { index, list in
                NavigationLink(destination: ListView(list: $viewModel.lists[index])) {
                    ListOverviewCard(list: list)
                }
            }
            Spacer()
        }
        .background(Color.backgroundColor.ignoresSafeArea())
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
