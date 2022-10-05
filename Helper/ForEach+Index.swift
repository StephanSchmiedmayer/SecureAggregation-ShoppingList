//
//  ForEach+Index.swift
//  shoppingList
//
//  Created by stephan on 18.09.21.
//

import Foundation
import SwiftUI

/// Wrapps ForEach
struct ForEachWithIndex<Collection: RandomAccessCollection, Content: View>: View
where Collection.Element: Identifiable {
    let data: Collection
    
    @ViewBuilder let content: (Collection.Element, Collection.Index) -> Content
    
    var body: some View {
        ForEach(Array(zip(data, data.indices)), id: \.0.id, content: content)
    }
}
