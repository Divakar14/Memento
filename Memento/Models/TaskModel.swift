//
//  TaskModel.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import Foundation

struct Task: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var dueDate: Date
    var priority: String
    var isNotificationEnabled: Bool
    var isMapEnabled: Bool
    var isCompleted: Bool
}
