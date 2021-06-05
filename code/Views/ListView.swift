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
    let listID: ShoppingList.ID
    
    /// List corresponding to listID. Optional because otherwise when the list gets deleted while this view is shown an IndexOutOfBounds Error is thrown
    var optionalList: ShoppingList? {
        viewModel.list(withID: listID)
    }
    
    //    @State private var animateBackground: Bool = false
    
    @State private var elementResponder: Bool? = false
    @State private var addElementText = ""
    
    init(listID: ShoppingList.ID) {
        UITableView.appearance().backgroundColor = .clear // For tableView
        UITableViewCell.appearance().backgroundColor = .clear // For tableViewCell
        self.listID = listID
    }
    
    private var background: some View {
        Color.backgroundColor.opacity(0.5)
    }
    
    var body: some View {
        ZStack {
            //            IrregularGradient(colors: [.blobColor1, .blobColor2],
            //                              background: LinearGradient(gradient: Gradient(colors: [.gradientStartColor, .gradientEndColor]), startPoint: .top, endPoint: .bottom),
            //                              speed: 10, shouldAnimate: $animateBackground)
            //                .ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [.gradientStartColor, .gradientEndColor]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            if let list = optionalList {
                List {
                    ForEach(list.elements) { element in
                        VStack(spacing: 0) {
                            ListElementView(list: list, element: element)
                        }
                    }
                    HStack {
                        TextField("Add new element", text: $addElementText, onCommit:  {
                            addElement(toList: list)
                        })
                        .frame(maxWidth: .infinity)
                        Button(action: {
                            addElement(toList: list)
                        }, label: {
                            Text("Add")
                                .bold()
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        })
                        .disabled(addElementText.isEmpty)
                    }
                    .listRowBackground(background)
                    //                        Button(action: { animateBackground.toggle() }, label: {
                    //                            Text(animateBackground ? "Animate" : "Static")
                    //                        })
                    Button(action: { viewModel.removeList(list)}, label: {
                        Text("Delete List")
                    })
                }
                .listStyle(SidebarListStyle())
                .navigationTitle(list.name)
                .navigationViewStyle(DoubleColumnNavigationViewStyle())
            }
            else {
                Text("List has been deleted")
            }
        }
    }
    
    private func addElement(toList list: ShoppingList) {
        guard addElementText != "" else { return }
        viewModel.addElement(addElementText, toList: list)
        addElementText = ""
    }
}

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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
            .preferredColorScheme(.dark)
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