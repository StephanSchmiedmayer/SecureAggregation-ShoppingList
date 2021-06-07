//
//  AddTextFieldView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI

struct AddTextFieldView: View {
    let textFieldDefaultText: String
    let processFinishedInput: (String) -> ()
    @State private var input = ""
    // TODO: Add button zu klein
    
    /**
     - Parameters:
        - textFieldDefaultText: Default Text to show when the TextField is empty
        - processFinishedInput: Function taking the String of the Textview (as inout) to process. Gets called when the users wants to add the Element. TextFieldInput gets automatically reset after calling this function.
     */
    init(textFieldDefaultText: String, processFinishedInput: @escaping (String) -> ()) {
        self.textFieldDefaultText = textFieldDefaultText
        self.processFinishedInput = processFinishedInput
    }
    
    var body: some View {
        HStack {
            TextField(textFieldDefaultText, text: $input, onCommit: callProcessFinishedInput)
            .frame(maxWidth: .infinity)
            Button(action: callProcessFinishedInput, label: {
                Text("Add")
                    .bold()
                    .foregroundColor(.accentColor)
            })
            .disabled(input.isEmpty)
        }
        .padding()
        .background(BlurredBackground())
        .cornerRadius(Constant.cornerRadius)
        .shadow(radius: 5)
        .padding(5)
    }
    
    func callProcessFinishedInput() {
        guard input != "" else { return }
        processFinishedInput(input)
        input = ""
    }
}

struct AddTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        AddTextFieldView(textFieldDefaultText: "Test", processFinishedInput: { _ in return })
    }
}
