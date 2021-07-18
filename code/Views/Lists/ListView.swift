//
//  ListView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI
//import EyeKit

struct ListView: View {
    @EnvironmentObject var viewModel: ShoppingListsViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var list: ShoppingList
    
    init(list: ShoppingList) {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        self.list = list
    }
    
    @State private var showDeletionAlert = false
    
    @State private var addElementText = ""
    
    var body: some View {
        if let name = list.name {
            VStack {
                List {
                    if let uncheckedElements = list.uncheckedElements {
                        ForEach(uncheckedElements) { element in
                            ListElementView(element: element, checked: false)
                        }
                        
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                viewModel.removeElement(uncheckedElements[index])
                            }
                        })
                    }
                    if list.showCheckedElements,
                       let checkedElements = list.checkedElements {
                        ForEach(checkedElements) { element in
                            ListElementView(element: element, checked: true)
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                viewModel.removeElement(
                                    checkedElements[checkedElements.index(checkedElements.startIndex,
                                                                          offsetBy: index)])
                            }
                        })
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.mode.wrappedValue.dismiss()
                                }
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
        label: {
            Image(systemName: "ellipsis.circle")
                .font(Font.system(size: 20))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            let preview = ShoppingListsViewModel.preview
            let context = preview.container.viewContext
            NavigationView {
                ListView(list: ShoppingList(context: context,
                                            id: UUID(),
                                            name: "Test",
                                            showCheckedElements: true,
                                            elements: [
                                                ShoppingElement(context: context, text: "Asdf"),
                                                ShoppingElement(context: context, text: "Testtt")
                                            ]))
                    .environment(\.managedObjectContext, preview.container.viewContext)
                    .environmentObject(preview)
            }
            .preferredColorScheme(scheme)
        }
    }
}
