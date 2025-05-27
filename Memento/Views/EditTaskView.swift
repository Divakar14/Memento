//
//  EditTaskView.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct EditTaskView: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var task: Task
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: String = "High"
    @State private var isNotificationEnabled: Bool = false
    @State private var isMapEnabled: Bool = false
    @State var showAlert: Bool = false
    @State private var alertType: MyAlerts? = nil
    
    enum MyAlerts {
        case discard
    }
    
    let priorities = ["Low", "Medium", "High"]
    
    init(task: Task) {
        self._task = State(initialValue: task)
        self._title = State(initialValue: task.title)
        self._description = State(initialValue: task.description)
        self._dueDate = State(initialValue: task.dueDate)
        self._priority = State(initialValue: task.priority)
        self._isNotificationEnabled = State(initialValue: task.isNotificationEnabled)
        self._isMapEnabled = State(initialValue: task.isMapEnabled)
    }
    
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
                    Button("Save Changes"){
                        let updatedTask = Task(
                            id: task.id,
                            title: title,
                            description: description,
                            dueDate: dueDate,
                            priority: priority,
                            isNotificationEnabled: isNotificationEnabled, isMapEnabled: isMapEnabled,
                            isCompleted: task.isCompleted
                        )
                        taskViewModel.updateTask(updatedTask)
                        dismiss()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.brandPrimary)
                    .foregroundColor(Color.brandHighlight)
                    .cornerRadius(12)
                    .disabled(title.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Edit Task")
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
    
    func getAlert() -> Alert {
        if alertType == .discard {
            return Alert(title: Text("You have Unsaved Changes"), message: nil, primaryButton: .destructive(Text("Discard")) {
                dismiss()
            }, secondaryButton: .default(Text("Save & Exit")) {
                let updatedTask = Task(
                    id: task.id,
                    title: title,
                    description: description,
                    dueDate: dueDate,
                    priority: priority,
                    isNotificationEnabled: isNotificationEnabled, isMapEnabled: isMapEnabled,
                    isCompleted: task.isCompleted
                )
                taskViewModel.updateTask(updatedTask)
                dismiss()
            } )
        } else {
            return Alert(title: Text(""), message: Text(""), dismissButton: .default(Text("OK")))
        }
    }
    
}

#Preview {
    EditTaskView(task: Task(
        id: UUID(), title: "Design Splash Screen",
            description: "Add animation and gradient background to the splash screen",
            dueDate: Date().addingTimeInterval(3600), // 1 hour later
            priority: "High",
            isNotificationEnabled: false,
            isMapEnabled: false,
            isCompleted: false))
}
