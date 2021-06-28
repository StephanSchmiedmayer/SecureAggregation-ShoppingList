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
    let listID: UUID
    
    @FetchRequest(entity: ShoppingList.entity(), sortDescriptors: [])
    private var lists: FetchedResults<ShoppingList>
    
    /// List corresponding to listID. Optional because otherwise when the list gets deleted while this view is shown an IndexOutOfBounds Error is thrown
    var optionalList: ShoppingList? {
        lists.first(where: { $0.id == listID })
    }
    
    @State private var showDeletionAlert = false
    
    @State private var addElementText = ""
    
    init(listID: UUID) {
        UIScrollView.appearance().backgroundColor = UIColor(Color.backgroundColor)
        self.listID = listID
    }
    
    var body: some View {
        if let list = optionalList,
           let name = list.name,
           let checkedElements = list.checkedElements?.array as? [ShoppingElement],
           let uncheckedElements = list.uncheckedElements?.array as? [ShoppingElement] {
            ScrollView {
                VStack(spacing: 1) {
                    ForEach(uncheckedElements) { element in
                        ListElementView(list: list, element: element, checked: false)
                    }
                    if list.showCheckedElements {
                        ForEach(checkedElements) { element in
                            ListElementView(list: list, element: element, checked: true)
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
            .overlay(AddTextFieldView(textFieldDefaultText: "Add new element") { input in
                withAnimation {
                    viewModel.addElement(text: input, toList: list)
                }
            }, alignment: .bottom)
            .navigationBarItems(trailing: settings)
            .navigationTitle(name)
            .alert(isPresented: $showDeletionAlert) {
                Alert(title: Text("Delete List?"),
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("Delete"), action: {
                        withAnimation {
                            viewModel.removeList(list)
                        }
                      }))
            }
        } else {
            Text("List has been deleted or failed to load")
                .foregroundColor(.red)
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
                Button {
                    showDeletionAlert = true
                } label: {
                    Label {
                        Text("Delete List")
                            .foregroundColor(.red)
                    } icon: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(ColorScheme.allCases, id: \.self) { scheme in
//            PreviewWrapper()
//                .preferredColorScheme(scheme)
//        }
//    }
//    
//    struct PreviewWrapper: View {
//        @StateObject var viewModel = ShoppingListsViewModel.preview
//        
//        @FetchRequest(entity: ShoppingList.entity(), sortDescriptors: [])
//        private var lists: FetchedResults<ShoppingList>
//
//        
//        var body: some View {
//            NavigationView {
//                ListView(listID: viewModel.)
//                    .environmentObject(viewModel)
//            }
//        }
//    }
//}
