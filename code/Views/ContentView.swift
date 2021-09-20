//
//  ContentView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 20.05.21.
//

import SwiftUI
import CoreData
import EyeKit

struct ContentView: View {
    @StateObject private var viewModel = ShoppingListsViewModel()
    
    @State private var showInformationView = !Client.shared.hasConsentedToTracking(for: DataReader.distance(refreshRate: 1))

    var body: some View {
        if showInformationView {
            let infoViewDescription = """
                ShoppingList tracks the distance between your eyes and your phone during usage and saves the results on a server.
                """
            Client.shared.informationView(applicationName: "ShoppingList",
                                          description: infoViewDescription,
                                          reader: [DataReader.distance(refreshRate: 1)],
                                          learnMoreURL: nil,
                                          completion: { showInformationView = !$0 })
        } else {
            TabView {
                ListsOverview()
                    .environment(\.managedObjectContext, viewModel.container.viewContext)
                    .environmentObject(viewModel)
                    .onAppear(perform: {
                        Client.shared.startTracking([DataReader.distance(refreshRate: 1)], completion: { result, _ in
                            switch result {
                            case .success():
                                break
                            case .failure(let error):
                                print(error)
                            }
                        })
                    })
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Lists")
                    }
                EvaluationOverview()
                    .tabItem {
                        Image(systemName: "eyes.inverse")
                        Text("Evaluation")
                    }
                AggregationView()
                    .tabItem {
                        Image(systemName: "network")
                        Text("Aggregation")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
*/
