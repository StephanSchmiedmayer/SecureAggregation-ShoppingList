//
//  ListView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI
import IrregularGradient

struct ListView: View {
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    /// ID of the list to show
    let listID: ShoppingList.ID
    
    /// List corresponding to listID. Optional because otherwise when the list gets deleted while this view is shown an IndexOutOfBounds Error is thrown
    var optionalList: ShoppingList? {
        viewModel.list(withID: listID)
    }
    
    @State private var addElementText = ""
    
    init(listID: ShoppingList.ID) {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        self.listID = listID
    }
    
    var body: some View {
        if let list = optionalList {
            ScrollView {
                VStack {
                    VStack(spacing: 1) {
                        ForEach(list.notCheckedElements) { element in
                            ListElementView(list: list, element: element)
                        }
                        if list.showCheckedElements {
                            ForEach(list.checkedElements) { element in
                                ListElementView(list: list, element: element)
                            }
                        }
                    }
                    .cornerRadius(Constant.cornerRadius)
                    .padding(.horizontal)
                    .padding(.top, 5)
                    AddTextFieldView(textFieldDefaultText: "", processFinishedInput: { _ in })
                        .hidden()
                        .id(-1)
                }
            }
            .overlay(AddTextFieldView(textFieldDefaultText: "Add new element"){ input in
                withAnimation {
                    viewModel.addElement(input, toList: list)
                }
            }, alignment: .bottom)
            .navigationBarItems(trailing: settings)
            .background(BackgroundView())
            .navigationTitle(list.name)
        }
        else {
            Text("List has been deleted")
        }
    }
    
    private var settings: some View {
        Menu {
            if let list = optionalList {
                Button {
                    withAnimation {
                        viewModel.toggleShowCheckedElements(of: list)
                    }
                } label: {
                    Label(list.showCheckedElements ? "Hide checked elements" : "Show checked elements",
                          systemImage: list.showCheckedElements ? "eye.slash" : "eye")
                }
            }
        }
        label: {
            Image(systemName: "ellipsis.circle")
        }
    }
    
    private func addElement(toList list: ShoppingList) {
        guard addElementText != "" else { return }
        viewModel.addElement(addElementText, toList: list)
        addElementText = ""
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            PreviewWrapper()
                .preferredColorScheme(scheme)
        }
    }
    
    struct PreviewWrapper: View {
        @StateObject var viewModel = ShoppingListsViewModel()
        
        var body: some View {
            NavigationView {
                ListView(listID: viewModel.lists[0].id)
                    .environmentObject(viewModel)
            }
        }
    }
}
