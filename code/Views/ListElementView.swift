//
//  ListElementView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI
import SwiftUIX

struct ListElementView: View {
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    @ObservedObject var element: ShoppingElement
    /// For better UI animations
    let checked: Bool
    
    @State private var editing = false
    @State private var editContent = ""
    
    var body: some View {
        if let text = element.text {
            HStack {
                Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(checked ? .gray : .accentColor)
                    .font(.system(size: 20))
                if editing {
                    CocoaTextField(text: $editContent,
                                   onCommit: {
                                    if editContent.isEmpty {
                                        viewModel.removeElement(element)
                                    } else {
                                        viewModel.changeTextOf(element: element, to: editContent)
                                    }
                                    editing = false
                                   }, label: { Text("") })
                    .isFirstResponder(true)
                } else {
                    Text(text)
                        .foregroundColor(checked ? .gray : nil)
                    Spacer()
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                withAnimation {
                    viewModel.toggleChecked(of: element)
                }
            }
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    editing = true
                    editContent = text
                }, label: {
                    Label("Edit", systemImage: "pencil")
                })
            }))
        } else {
            Text("Error loading Element")
                .foregroundColor(.red)
        }
    }
}

struct ListElementView_Previews: PreviewProvider {
    private static var element: ShoppingElement {
        let result = ShoppingElement()
        result.id = UUID()
        result.text = "SampleElement"
        return result
    }
    private static var list: ShoppingList {
        let result = ShoppingList()
        result.name = "Test"
        result.id = UUID()
        return result
    }
    
    static var previews: some View {
        ListElementView(element: element, checked: true)
        ListElementView(element: element, checked: false)
    }
}
