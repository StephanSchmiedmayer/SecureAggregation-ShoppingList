//
//  EvaluationView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 23.05.21.
//

import SwiftUI

struct EvaluationView: View {
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                let colors: [Color] = [.red, .yellow, .green, .blue]
                LinearGradient(gradient: Gradient(colors: colors),
                               startPoint: .leading,
                               endPoint: .trailing)
                LinearGradient(gradient: Gradient(colors: colors),
                               startPoint: .trailing,
                               endPoint: .leading)
            }
            .height(10)
            .cornerRadius(5)
        }
        .navigationTitle("Average reading distance")
    }
}

struct EvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EvaluationView()
        }
    }
}
