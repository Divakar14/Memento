//
//  NoteViewModel.swift
//  Memento
//
//  Created by Divakar T R on 26/05/25.
//

import Foundation

class NoteViewModel: ObservableObject {
    
    @Published var notes: [Note] = []
    
    func addNote(title: String, content: String, createdDate: Date) {
        let newNote = Note(id: UUID(), title: title, content: content, createdDate: createdDate)
        notes.append(newNote)
    }
    
    func updateNote(_ updatedNote: Note) {
        if let index = notes.firstIndex(where: { $0.id == updatedNote.id }) {
            notes[index] = updatedNote
        }
    }
    
    func deleteNote(_ note: Note) {
        notes.removeAll{ $0.id == note.id }
    }
    
}
