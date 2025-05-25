//
//  TaskCard.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct TaskCard: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    var task: Task
    @State var showEditTask: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Button(action: {
                    taskViewModel.toggleTaskCompletion(task)
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                }
                .buttonStyle(.plain)
                Text(task.title)
                    .font(.headline)
                Spacer()
                Text(task.priority)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(priorityColor(task.priority))
                    .cornerRadius(8)
            }
            Text(task.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .shortened))")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .contextMenu {
            Button("Mark as \(task.isCompleted ? "Incomplete" : "Completed")") {
                taskViewModel.toggleTaskCompletion(task)
            }
            Button("Edit Task") {
                showEditTask = true
            }
            Button(role: .destructive) {
                taskViewModel.deleteTask(task)
            } label: {
                Text("Delete")
            }
        }
        .fullScreenCover(isPresented: $showEditTask) {
            EditTaskView(task: task).environmentObject(taskViewModel)
        }
    }
    
    func priorityColor(_ level: String) -> Color {
        switch level {
        case "High": return .red
        case "Medium": return .orange
        case "Low": return .blue
        default: return .gray
        }
    }
    
}

#Preview {
    var taskViewModel: TaskViewModel = TaskViewModel()
    TaskCard(task: Task(
        id: UUID(), title: "Design Splash Screen",
            description: "Add animation and gradient background to the splash screen",
            dueDate: Date().addingTimeInterval(3600), // 1 hour later
            priority: "High",
            isNotificationEnabled: false,
            isMapEnabled: false,
            isCompleted: false
    )).environmentObject(taskViewModel)
}
