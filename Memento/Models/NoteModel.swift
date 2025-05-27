//
//  NoteModel.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import Foundation

struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var createdDate: Date
}
