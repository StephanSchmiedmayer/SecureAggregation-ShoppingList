//
//  ListView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI
import IrregularGradient

struct ListView: View {
    @Binding var list: ShoppingList
    @EnvironmentObject var viewModel: ShoppingListsViewModel
//    @State var animateBackground = true
    
//    init(list: ShoppingList) {
//        UITableView.appearance().backgroundColor = .clear // For tableView
//        UITableViewCell.appearance().backgroundColor = .clear // For tableViewCell
//        self.list = list
//    }
    
    var body: some View {
//        ZStack {
//            IrregularGradient(colors: [Color(#colorLiteral(red: 0.02745098039, green: 0.1921568627, blue: 0.3960784314, alpha: 1)),Color(#colorLiteral(red: 0, green: 0.01568627451, blue: 0.1568627451, alpha: 1)),Color(#colorLiteral(red: 0.02745098039, green: 0.1921568627, blue: 0.3960784314, alpha: 1))],
//                              background: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.02352941176, green: 0.168627451, blue: 0.3647058824, alpha: 1)), Color(#colorLiteral(red: 0.01568627451, green: 0.07450980392, blue: 0.231372549, alpha: 1))]), startPoint: .top, endPoint: .bottom),
//                              speed: 10, shouldAnimate: $animateBackground)
//                .ignoresSafeArea()
            List {
                forEach(data: list.elements) { index, element in
//                ForEach(list.elements) { element in
                    HStack {
                        Image(systemName: element.done ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(element.done ? .gray : .accentColor)
                            .onTapGesture {
                                list.elements[index].toggleDone()
                            }
                        Text(element.text)
                            .foregroundColor(element.done ? .gray : nil)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(element.id)")
                    }
//                    .listRowBackground {
//                        Blur
//                    }
                }
            }
            .navigationTitle(list.name)
//        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @StateObject var viewModel = ShoppingListsViewModel()

        var body: some View {
            NavigationView {
                ListView(list: $viewModel.lists[0])
                    .environmentObject(viewModel)
            }
        }
    }
}
