//
//  CardView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI

struct CardView<Content: View, Title: View>: View {
    let title: Title
    let content: Content
    let isNavigationLink: Bool
    
    /**
     - Parameters:
        - title: Title of the card
        - isNavigationLink: Display this card with indication of it being a NavigationLink, defaults to ture
        - content: View displayed in the body of the card
     */
    init(title: String,
         isNavigationLink: Bool = true,
         @ViewBuilder _ content: () -> Content) where Title == AnyView {
        self.title = AnyView(Text(title).headline())
        self.content = content()
        self.isNavigationLink = isNavigationLink
    }
    
    /**
     - Parameters:
        - isNavigationLink: Display this card with indication of it being a NavigationLink, defaults to ture
        - titleAndContent: Two views: TItle of the card and content of the card
     */
    init(isNavigationLink: Bool = true,
         @ViewBuilder titleAndContent: () -> TupleView<(Title, Content)>) {
        (self.title, self.content) = titleAndContent().value
        self.isNavigationLink = isNavigationLink
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                title
                Spacer()
                if isNavigationLink {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .foregroundColor(.secondary)
                }
            }
            content
        }
        .padding(.all)
        .background(Color.foregroundColor)
        .cornerRadius(Constant.cornerRadius)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CardView(title: "Test") {
                Text("Test")
            }
            Spacer()
        }
        .background(Color.backgroundColor.ignoresSafeArea())
    }
}
