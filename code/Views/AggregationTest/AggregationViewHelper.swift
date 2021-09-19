//
//  File.swift
//  shoppingList
//
//  Created by stephan on 18.09.21.
//

import Foundation
import SwiftUI
import SecureAggregationClient
import SecureAggregationCore

struct AggregationStateView: View {
    @ObservedObject var viewModel: AggregationViewModel
    
    /// Name of the (one time) action sent to the server
    let serverActionName: String
    
    /// Action changing the state of the server to the desired state (if possible).
    ///
    /// Gets called with the first controller of viewModel.controller
    let serverAction: (BasicSecureAggregationController<SAInt>) -> Void
    
    /// Name of the action executed for each Controller
    let controllerActionName: String
    
    /// Action executed with each controller
    let controllerAction: (BasicSecureAggregationController<SAInt>) -> Void
    
    var body: some View {
        Form {
            Section(header: Text(serverActionName)) {
                if let firstController = viewModel.controllers.first {
                    Button(action: {
                        serverAction(firstController)
                    }, label: {
                        Text("Send \(serverActionName.lowercased()) signal")
                    })
                }
            }
            Section(header: Text(controllerActionName)) {
                ForEachWithIndex(data: viewModel.controllers) { controller, index in
                    Button(action: {
                        controllerAction(controller)
                    }, label: {
                        HStack {
                            Text("\(controllerActionName.lowercased()) \(index): \(controller.description)")
                            if controller.requestInProgress {
                                ProgressView()
                            }
                        }
                    })
                }
            }
        }
    }
}
