//
//  AggregationSwipeView.swift
//  shoppingList
//
//  Created by stephan on 19.09.21.
//

import Foundation
import SwiftUI

struct AggregationSwipeView: View {
    @ObservedObject var viewModel: AggregationViewModel
    
    var body: some View {
        TabView {
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Start",
                                 serverAction: { $0.start() },
                                 controllerActionName: "Login",
                                 controllerAction: { $0.login() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Finish login",
                                 serverAction: { $0.finishLogin() },
                                 controllerActionName: "Setup",
                                 controllerAction: { $0.setup() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Finish setup",
                                 serverAction: { $0.finishSetup() },
                                 controllerActionName: "Send Round 0 message",
                                 controllerAction: { $0.round0SendMessage() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Finish Round 0 Collection",
                                 serverAction: { $0.finishRound0Collection() },
                                 controllerActionName: "Donwload Round 0 message",
                                 controllerAction: { $0.round0DownloadServerMessage() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Advance to Round 1",
                                 serverAction: { $0.advanceToRound1() },
                                 controllerActionName: "Send Round 1 message",
                                 controllerAction: { $0.round1SendMessage() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Finish Round 1 Collection",
                                 serverAction: { $0.finishRound1Collection() },
                                 controllerActionName: "Donwload Round 1 message",
                                 controllerAction: { $0.round1DownloadServerMessage() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Advance to Round 2",
                                 serverAction: { $0.advanceToRound2() },
                                 controllerActionName: "Send Round 2 message",
                                 controllerAction: { $0.round2SendMessage() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Finish Round 2 Collection",
                                 serverAction: { $0.finishRound2Collection() },
                                 controllerActionName: "Donwload Round 2 message",
                                 controllerAction: { $0.round2DownloadServerMessage() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Advance to Round 4",
                                 serverAction: { $0.advanceToRound4() },
                                 controllerActionName: "Send Round 4 message",
                                 controllerAction: { $0.round4SendMessage() })
            
            AggregationStateView(viewModel: viewModel,
                                 serverActionName: "Finish Round 4 Collection",
                                 serverAction: { $0.finishRound4Collection() },
                                 controllerActionName: "Donwload Round 4 message",
                                 controllerAction: { $0.round4DownloadServerMessage() })
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
