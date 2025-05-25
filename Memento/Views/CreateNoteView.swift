//
//  CreateNoteView.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct CreateNoteView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var noteTitle: String = ""
    @State private var noteBody: String = ""
    @State private var createdDate: Date = Date()
    @FocusState private var isFocused: Bool
    
    let priorities = ["Low", "Medium", "High"]
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading, spacing: 20){
                
                TextField("Note Title", text: $noteTitle)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .focused($isFocused)
                
                ZStack(alignment: .topLeading) {
                    if noteBody.isEmpty {
                        Text("Write your note...")
                            .foregroundColor(.gray)
                            .padding(12)
                    }
                    TextEditor(text: $noteBody)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .frame(minHeight: 250)
                        .focused($isFocused)
                }
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Color.brandAccent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        // Save logic
                        dismiss()
                    }
                    .foregroundStyle(Color.brandAccent)
                    .disabled(noteTitle.isEmpty || noteBody.isEmpty)
                }
            }
//            .background(Color.brandAccent)
        }
    }
}

#Preview {
    CreateNoteView()
}
