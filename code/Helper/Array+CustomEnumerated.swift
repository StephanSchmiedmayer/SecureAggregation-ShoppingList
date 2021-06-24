//
//  Array+CustomEnumerated.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 03.06.21.
//

import SwiftUI

func forEach<Element, Content>(data: [Element], content: @escaping (Int, Element) -> Content)
-> ForEach<[(Int, Element)], Element.ID, Content>
where Element: Identifiable, Content: View {
    ForEach(Array(zip(data.indices, data)), id: \.1.id, content: content)
}
