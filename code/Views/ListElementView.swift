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
    let element: ShoppingElement
    let checked: Bool
    
    var body: some View {
        if let text = element.text {
            HStack {
                Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(checked ? .gray : .accentColor)
                    .font(.system(size: 20))
                Text(text)
                    .foregroundColor(checked ? .gray : nil)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.foregroundColor)
            .contentShape(Rectangle())
            .onTapGesture {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                withAnimation {
                    viewModel.toggleChecked(of: element, inList: list)
                }
            }
        } else {
            Text("Error loading Element")
                .foregroundColor(.red)
        }
    }
}
/*
struct ListElementView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @StateObject var viewModel = ShoppingListsViewModel()
        
        var body: some View {
            ListElementView(list: viewModel.lists[0], element: viewModel.lists[0].checkedElements[0])
                .environmentObject(viewModel)
        }
    }
}

*/
