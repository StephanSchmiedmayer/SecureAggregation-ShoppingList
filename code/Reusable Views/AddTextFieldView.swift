//
//  AddTextFieldView.swift
//  shoppingList
//
//  Created by Stephan Schmiedmayer on 07.06.21.
//

import SwiftUI

struct AddTextFieldView: View {
    let textFieldDefaultText: String
    let onStartEditing: () -> Void
    let processFinishedInput: (String) -> Void
    @State private var input = ""
    // TODO: Add button zu klein
    
    /**
     - Parameters:
        - textFieldDefaultText: Default Text to show when the TextField is empty
        - onStartEditing: Function called when the user starts writing into the TextField
        - processFinishedInput: Function taking the String of the Textview (as inout) to process. Gets called when the users wants to add the Element. TextFieldInput gets automatically reset after calling this function.
     */
    init(textFieldDefaultText: String,
         onStartEditing: @escaping () -> Void = { },
         processFinishedInput: @escaping (String) -> Void) {
        self.textFieldDefaultText = textFieldDefaultText
        self.onStartEditing = onStartEditing
        self.processFinishedInput = processFinishedInput
        UITextView.appearance().backgroundColor = UIColor(Color.foregroundColor)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextField(textFieldDefaultText,
                      text: $input,
                      onEditingChanged: { if $0 { onStartEditing() } },
                      onCommit: callProcessFinishedInput)
                .frame(maxWidth: .infinity)
                .padding(.leading)
                .padding(.vertical)
                .contentShape(Rectangle())
            Button(action: callProcessFinishedInput, label: {
                Text("Add")
                    .bold()
                    .foregroundColor(.accentColor)
                    .padding()
            })
            .disabled(input.isEmpty)
        }
        .background(BlurredBackground())
        .cornerRadius(Constant.cornerRadius)
        .shadow(radius: 5)
        .padding(5)
    }
    
    func callProcessFinishedInput() {
        guard !input.isEmpty else { return }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        processFinishedInput(input)
        input = ""
    }
}

struct AddTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AddTextFieldView(textFieldDefaultText: "Test", processFinishedInput: { _ in return })
            Spacer()
        }
            .background(Color.backgroundColor.ignoresSafeArea())
    }
}
