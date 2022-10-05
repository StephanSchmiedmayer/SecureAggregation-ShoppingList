//
//  Fonts.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI

extension Text {
    /// Headline of a Card
    func headline() -> some View {
        self
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .padding(.bottom, Constant.cardHeadlineSpacing)
            .foregroundColor(.accentColor)
    }
}
