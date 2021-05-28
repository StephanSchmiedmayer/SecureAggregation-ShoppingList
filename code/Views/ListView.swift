//
//  ListView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI

struct ListView: View {
    var list: ShoppingList
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    
    var body: some View {
        VStack {
            List(list.elements) { element in
                HStack {
                    Image(systemName: element.done ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(element.done ? .gray : .accentColor)
                        .onTapGesture {
                            viewModel.toggleDone(of: element, inList: list)
                        }
                    Text(element.text)
                        .foregroundColor(element.done ? .gray : nil)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .navigationTitle(list.name)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(list: ShoppingList(name: "Preview", elements: [
            ShoppingListElement(done: false, text: "One"),
            ShoppingListElement(done: false, text: "Two"),
            ShoppingListElement(done: true, text: "According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyway"),

        ]))
        .environmentObject(ShoppingListsViewModel())
    }
}
