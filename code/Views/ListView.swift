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
    
    init(listID: UUID) {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        self.listID = listID
    }

    @State private var showDeletionAlert = false
    
    @State private var addElementText = ""
    
    var body: some View {
        if let list = optionalList,
           let name = list.name,
           let checkedElements = list.checkedElements?.array as? [ShoppingElement],
           let uncheckedElements = list.uncheckedElements?.array as? [ShoppingElement] {
            VStack {
                List {
                    ForEach(uncheckedElements) { element in
                        ListElementView(list: list, element: element, checked: false)
                    }
                    if list.showCheckedElements {
                        ForEach(checkedElements) { element in
                            ListElementView(list: list, element: element, checked: true)
                        }
                    }
                }
                .listStyle(PlainListStyle())
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
                AddTextFieldView(textFieldDefaultText: "Add new element") { input in
                    withAnimation {
                        viewModel.addElement(text: input, toList: list)
                    }
                }
                .background(Color.clear)
            }
        } else {
            EmptyView()
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
                .font(Font.system(size: 20))
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var list: ShoppingList {
//        let result = ShoppingList()
//        result.name = "Test"
//        result.id = UUID()
//        result.
//    }
//    
//    static var previews: some View {
//        ForEach(ColorScheme.allCases, id: \.self) { scheme in
//            let preview = ShoppingListsViewModel.preview
//            NavigationView {
//                // swiftlint:disable:next force_unwrapping
//                ListView(listID: UUID(uuidString: "8C97824E-E975-490B-B76B-FDBD4070F512")!)
//                    .environment(\.managedObjectContext, preview.container.viewContext)
//                    .environmentObject(preview)
//            }
//            .preferredColorScheme(scheme)
//        }
//    }
//}
