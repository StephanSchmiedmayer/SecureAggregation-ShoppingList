//
//  CustomDivider.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 05.06.21.
//

import SwiftUI

enum Orientation {
    case horizontal
    case vertical
}

struct CustomDivider: View {
    var width: CGFloat = 1
    var color: Color = .gray.opacity(0.5)
    var orientation: Orientation = .horizontal
    var body: some View {
        switch orientation {
        case .horizontal:
            Rectangle()
                .fill(color)
                .frame(height: width)
                .edgesIgnoringSafeArea(.horizontal)
        case .vertical:
            Rectangle()
                .fill(color)
                .frame(width: width)
                .edgesIgnoringSafeArea(.vertical)

        }
        
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
