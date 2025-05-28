//
//  TaskCard.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct NoteCard: View {
    
    @EnvironmentObject var noteViewModel: NoteViewModel
    var note: Note
    @State var showEditNote: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(note.title)
                    .font(.headline)
                Spacer()
            }
            Text(note.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let imageDataList = note.imageDataList {
                ForEach(imageDataList, id: \.self) { data in
                    if let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .cornerRadius(12)
                    }
                }
            }
            Text("Created Date: \(note.createdDate.formatted(date: .abbreviated, time: .shortened))")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .contextMenu {
            Button("Edit Note") {
                showEditNote = true
            }
            Button(role: .destructive) {
                noteViewModel.deleteNote(note)
            } label: {
                Text("Delete")
            }
        }
        .fullScreenCover(isPresented: $showEditNote) {
            EditNoteView(note: note).environmentObject(noteViewModel)
        }
    }
    
}

#Preview {
    var noteViewModel: NoteViewModel = NoteViewModel()
    NoteCard(note: Note(
        id: UUID(), title: "Design Splash Screen",
            content: "Add animation and gradient background to the splash screen",
            createdDate: Date().addingTimeInterval(3600) // 1 hour later
    )).environmentObject(noteViewModel)
}
