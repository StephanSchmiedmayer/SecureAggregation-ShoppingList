//
//  AggregationViewModel.swift
//  shoppingList
//
//  Created by stephan on 18.09.21.
//

import Foundation
import SwiftUI
import SecureAggregationClient
import SecureAggregationCore
import Combine

class AggregationViewModel: ObservableObject {
    @Published private(set) var controllers: [BasicSecureAggregationController<SAInt>] = [] {
        didSet {
            controllers.forEach { controller in
                controller
                    .objectWillChange.sink { [weak self] _ in
                        self?.objectWillChange.send()
                    }
                    .store(in: &viewModelWillChangeCancellable)
            }
        }
    }
    
    private let serverBaseURL = URL(string: "http://127.0.0.1:8080")! // swiftlint:disable:this force_unwrapping
    
    @Published var textInput: String = ""
    
    private var viewModelWillChangeCancellable: Set<AnyCancellable> = []
        
    /// Values of all controllers, in preserved order
    var values: [SAInt] {
        controllers.map {
            $0.value
        }
    }
    
    /// Status of all controllers, in preserved order
    var status: [SecureAggregationStatus<SAInt>] {
        controllers.map {
            $0.status
        }
    }
    
    /// Tries to create new controllers from the textInput
    func createNewControllers() {
        withAnimation {
            controllers = []
            textInput
                .filter {
                    $0 != " "
                }
                .split(separator: ",")
                .compactMap { substring in
                    Int(substring)
                }
                .map {
                    BasicSecureAggregationController(value: SAInt($0), serverBaseURL: serverBaseURL)
                }
                .forEach { controller in
                    controllers.append(controller)
                }
        }
    }
}
