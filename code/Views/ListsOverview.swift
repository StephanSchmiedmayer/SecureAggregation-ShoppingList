//
//  ListsOverview.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI

struct ListsOverview: View {
    @ObservedObject var viewModel = ShoppingListsViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.lists) { list in
                NavigationLink(
                    destination: ListView(list: list)
                        .environmentObject(viewModel)){
                    HStack {
                        Text(list.name)
                            .font(.title2)
                            .foregroundColor(.textColor)
                        Spacer()
                        Text("\(list.elements.count)")
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.foregroundColor)
                    .cornerRadius(Constants.cornerRadius)
                    .padding()
                }
            }
            Spacer()
        }
        .background(Color.backgroundColor.ignoresSafeArea())
    }
}

struct ListsOverview_Previews: PreviewProvider {
    static var previews: some View {
        ListsOverview()
    }
}
