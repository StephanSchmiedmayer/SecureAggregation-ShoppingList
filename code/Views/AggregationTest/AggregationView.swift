//
//  AggregationView.swift
//  shoppingList
//
//  Created by stephan on 15.07.21.
//

import SwiftUI
import SecureAggregationClient
import SecureAggregationCore

struct AggregationView: View {
    @StateObject var viewModel = AggregationViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Create Controllers")) {
                    if viewModel.controllers.isEmpty {
                        Text("""
                    Input a comma-separated list of values that should get aggregated.
                    Each value simulates a client.
                    """)
                    }
                    TextField("Comma-sparated list of values",
                              text: $viewModel.textInput,
                              onCommit: viewModel.createNewControllers)
                }
                if !viewModel.controllers.isEmpty {
                    Section(header: Text("Created Controllers")) {
                        Text("Created \(viewModel.controllers.count) controllers:")
                        ForEachWithIndex(data: viewModel.controllers) { controller, index in
                            Text("\(index): \(controller.description)")
                        }
                    }
                    Section(header: Text("Next step")) {
                        NavigationLink(
                            destination: AggregationSwipeView(viewModel: viewModel),
                            label: {
                                Text("Get to the fun")
                            })
                        Text("Start will reset the server model")
                    }
                }
            }
            .background(Color.backgroundColor.ignoresSafeArea())
        }
    }
}

//struct AggregationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AggregationView()
//    }
//}
