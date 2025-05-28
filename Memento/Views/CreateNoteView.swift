//
//  CreateNoteView.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct CreateNoteView: View {
    
    @EnvironmentObject var noteViewModel: NoteViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var createdDate: Date = Date()
    @State private var showImagePicker: Bool = false
    @State private var selectedImages: [UIImage] = []
    @State private var isPreviewing: Bool = false
    @State var showAlert: Bool = false
    @State private var alertType: MyAlerts? = nil
    
    enum MyAlerts {
        case discard
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
                    
                    ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                        VStack(alignment: .leading) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)
                                .cornerRadius(12)
                            Button("Remove Image") {
                                selectedImages.remove(at: index)
                            }
                            .foregroundColor(.red)
                        }
                    }
                    
                    if isPreviewing {
                        Text(.init(content))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    } else {
                        markdownToolbar
                        TextEditor(text: $content)
                            .padding(8)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            .frame(minHeight: 250)
                    }
                    
                    Button(action: {
                        saveNote()
                    }) {
                        Text("Save Note")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(title.isEmpty ? Color.gray.opacity(0.5) : Color.brandPrimary)
                            .foregroundColor(title.isEmpty ? .primary : Color.brandHighlight)
                            .cornerRadius(12)
                    }
                    .disabled(title.isEmpty && content.isEmpty)
                    .padding(.top)
                    
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImages: $selectedImages)
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
    
    func saveNote() {
        let imageDataList = selectedImages.map { $0.jpegData(compressionQuality: 0.8)! }
        noteViewModel.addNote(title: title, content: content, createdDate: createdDate, imageDataList: imageDataList)
        dismiss()
    }
    
    func getAlert() -> Alert {
        if alertType == .discard {
            return Alert(title: Text("You have Unsaved Changes"), message: nil, primaryButton: .destructive(Text("Discard")) {
                dismiss()
            }, secondaryButton: .default(Text("Save & Exit")) {
                saveNote()
            } )
        } else {
            return Alert(title: Text(""), message: Text(""), dismissButton: .default(Text("OK")))
        }
    }
    
    var markdownToolbar: some View {
        HStack {
            markdownButton("**", tooltip: "Bold")
            markdownButton("*", tooltip: "Italic")
            markdownButton("##", tooltip: "Heading")
            markdownButton("`", tooltip: "Code")
            markdownButton("-", tooltip: "Bullet")
        }
        .font(.system(size: 18, weight: .bold))
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
    
    func markdownButton(_ tag: String, tooltip: String) -> some View {
        Button(action: {
            insertMarkdown(tag)
        }) {
            Text(tag)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color(.systemGray4))
                .cornerRadius(6)
                .accessibilityLabel(tooltip)
        }
    }
    
    func insertMarkdown(_ syntax: String) {
        switch syntax {
            case "**", "*", "`":
                // Inline formatting - just append
                content += "\(syntax)\(syntax)"
            case "##":
                // Heading formatting - insert at start of new line
                content += "\n\(syntax) "
            case "-":
                // Bullet formatting - insert bullet point
                content += "\n- "
            default:
                break
            }
    }
    
}

#Preview {
    CreateNoteView()
}

