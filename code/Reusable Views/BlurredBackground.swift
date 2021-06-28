//
//  BlurredBackground.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI

struct BlurredBackground: View {
    @Environment(\.colorScheme) var colorScheme
    var blurEffectStyle: UIBlurEffect.Style {
        switch colorScheme {
        case .dark: return .dark
        case .light: return .extraLight
        @unknown default:
            return .dark
        }
    }

    var body: some View {
        VisualEffectView(effect: UIBlurEffect(style: blurEffectStyle))
    }
}

//struct BlurredBackground_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.gradientStartColor,
//                                                                   .gradientEndColor]),
//                                       startPoint: .top, endPoint: .bottom)
//
//            Text("Test")
//                .padding()
//                .background(BlurredBackground())
//        }
//    }
//}
