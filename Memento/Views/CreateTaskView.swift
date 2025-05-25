//
//  CreateTaskView.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct CreateTaskView: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: String = "High"
    @State private var isNotificationEnabled: Bool = false
    @State private var isMapEnabled: Bool = false
    
    
    let priorities = ["Low", "Medium", "High"]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 20) {
                    TextField("Task Title:", text: $title)
                        .padding()
                        .background(Color(.systemGray6))
//                        .background(Color(#colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1)))
                        .cornerRadius(12)
                    TextField("Description:", text: $description, axis: .vertical)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .lineLimit(3...6)
                    DatePicker("Due Date:", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id: \.self) { level in
                            Text(level)
                                .tag(level)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top)
                    Toggle("Enable Notification", isOn: $isNotificationEnabled)
                        .tint(.brandAccent)
                        .padding()
                    Toggle("Atatch Map Location", isOn: $isMapEnabled)
                        .tint(.brandAccent)
                        .padding()
                    Button(action: {
                        saveTask()
                    }) {
                        Text("Save Task")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(title.isEmpty ? Color.gray.opacity(0.5) : Color.brandPrimary)
                            .foregroundColor(title.isEmpty ? .primary : Color.brandHighlight)
                            .cornerRadius(12)
                    }
                    .disabled(title.isEmpty)
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Color.brandAccent)
                }
            }
        }
    }
    
    func saveTask() {
        taskViewModel.addTask(title: title, description: description, dueDate: dueDate, priority: priority, isNotificationEnabled: isNotificationEnabled, isMapEnabled: isMapEnabled, isCompleted: false)
        print("Task saved!" +  "\(taskViewModel.tasks)")
        dismiss()
    }
    
}

#Preview {
    CreateTaskView()
}
