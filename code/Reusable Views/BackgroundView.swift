//
//  BackgroundView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
//            IrregularGradient(colors: [.blobColor1, .blobColor2],
//                              background: LinearGradient(gradient: Gradient(colors: [.gradientStartColor, .gradientEndColor]), startPoint: .top, endPoint: .bottom),
//                              speed: 10, shouldAnimate: $animateBackground)
//                .ignoresSafeArea()
        LinearGradient(gradient: Gradient(colors: [.gradientStartColor,
                                                   .gradientEndColor]),
                       startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
