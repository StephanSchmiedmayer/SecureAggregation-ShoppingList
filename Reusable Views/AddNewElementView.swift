//
//  AddNewElementView.swift
//  shoppingList
//
//  Created by stephan on 04.08.21.
//

import SwiftUI

struct AddNewElementView: View {
    @State private var input = ""
    
    let viewModel: ShoppingListsViewModel
    let list: ShoppingList

    var body: some View {
        HStack(spacing: 0) {
            TextField("Add new element",
                      text: $input,
                      onEditingChanged: { config.updateLastAction(to: $0 ? .beganAddNewElement: .closedAddNewElement) },
                      onCommit: processFinishedInput)
                .frame(maxWidth: .infinity)
                .padding(.leading)
                .padding(.vertical)
                .font(Font.system(size: config.listFontSize))
                .foregroundColor(config.listTextColor)
            Button(action: processFinishedInput, label: {
                Text("Add")
                    .bold()
                    .font(Font.system(size: config.listFontSize))
                    .foregroundColor(.accentColor)
                    .padding()
            })
            .disabled(input.isEmpty)
        }
        .background(BlurredBackground())
        .cornerRadius(Constant.cornerRadius)
        .shadow(radius: 5)
        .padding(5)
    }
    
    func processFinishedInput() {
        guard !input.isEmpty else { return }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        withAnimation {
            viewModel.addElement(text: input, toList: list)
        }
        config.updateLastAction(to: .addedNewElement)
        input = ""
    }
}

//struct AddNewElementView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewElementView()
//    }
//}
