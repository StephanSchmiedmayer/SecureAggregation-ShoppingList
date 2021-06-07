//
//  ListElementView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI

struct ListElementView: View {
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    let list: ShoppingList
    let element: ShoppingListElement
    
    var body: some View {
        HStack {
            Image(systemName: element.done ? "checkmark.circle.fill" : "circle")
                .foregroundColor(element.done ? .gray : .accentColor)
                .font(.system(size: 20))
            Text(element.text)
                .foregroundColor(element.done ? .gray : nil)
            Spacer()
        }
        .onTapGesture {
            viewModel.toggleDone(of: element, inList: list)
        }
    }
}

struct ListElementView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @StateObject var viewModel = ShoppingListsViewModel()
        
        var body: some View {
            ListElementView(list: viewModel.lists[0], element: viewModel.lists[0].elements[0])
                .environmentObject(viewModel)
        }
    }
}
