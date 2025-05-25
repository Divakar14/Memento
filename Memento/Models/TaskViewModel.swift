//
//  TaskViewModel.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    func addTask(title: String, description: String, dueDate: Date, priority: String, isNotificationEnabled: Bool, isMapEnabled: Bool,isCompleted: Bool) {
        let newTask = Task(id: UUID(), title: title, description: description, dueDate: dueDate, priority: priority, isNotificationEnabled: isNotificationEnabled, isMapEnabled: isMapEnabled, isCompleted: isCompleted)
        tasks.append(newTask)
    }
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func updateTask(_ updatedTask: Task) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll{ $0.id == task.id }
    }
    
}
