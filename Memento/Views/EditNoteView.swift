//
//  EditnoteView.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct EditNoteView: View {
    
    @EnvironmentObject var noteViewModel: NoteViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var note: Note
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var createdDate: Date = Date()
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var isPreviewing: Bool = false
    @State var showAlert: Bool = false
    @State private var alertType: MyAlerts? = nil
    
    enum MyAlerts {
        case discard
    }
    
    init(note: Note) {
        self._note = State(initialValue: note)
        self._title = State(initialValue: note.title)
        self._content = State(initialValue: note.content)
        self._createdDate = State(initialValue: note.createdDate)
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 20){
                    
                    TextField("Note Title", text: $title)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    
                    HStack {
                        Button("Insert Image") {
                            showImagePicker = true
                        }
                        Spacer()
                        Button(isPreviewing ? "Edit Markdown" : "Preview"){
                            isPreviewing.toggle()
                        }
                    }
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .cornerRadius(12)
                    }
                    
                    if isPreviewing {
                        Text(.init(content))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    } else {
                        TextEditor(text: $content)
                            .padding(8)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            .frame(minHeight: 250)
                    }
                    
                    Button("Save Changes"){
                        let updatedNote = Note(
                            id: note.id,
                            title: title,
                            content: content,
                            createdDate: createdDate
                        )
                        noteViewModel.updateNote(updatedNote)
                        dismiss()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.brandPrimary)
                    .foregroundColor(Color.brandHighlight)
                    .cornerRadius(12)
                    .disabled(title.isEmpty)
                    .padding(.top)
                }
                .padding()
                .navigationTitle("New Note")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            if (!title.isEmpty){
                                alertType = .discard
                                showAlert = true
                            } else {
                                dismiss()
                            }
                        }
                        .foregroundStyle(Color.brandAccent)
                    }
                }
                .alert(isPresented: $showAlert) {
                    getAlert()
                }
            }
        }
    }
    
    func getAlert() -> Alert {
        if alertType == .discard {
            return Alert(title: Text("You have Unsaved Changes"), message: nil, primaryButton: .destructive(Text("Discard")) {
                dismiss()
            }, secondaryButton: .default(Text("Save & Exit")) {
                let updatedNote = Note(
                    id: note.id,
                    title: title,
                    content: content,
                    createdDate: createdDate
                )
                noteViewModel.updateNote(updatedNote)
                dismiss()
            } )
        } else {
            return Alert(title: Text(""), message: Text(""), dismissButton: .default(Text("OK")))
        }
    }
    
}

#Preview {
    EditNoteView(note: Note(
        id: UUID(), title: "Design Splash Screen",
            content: "Add animation and gradient background to the splash screen",
            createdDate: Date().addingTimeInterval(3600), // 1 hour later
    ))
}
