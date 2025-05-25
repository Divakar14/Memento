//
//  TaskProgressView.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct TaskProgressView: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        let total = taskViewModel.tasks.count
        let completed = taskViewModel.tasks.filter { $0.isCompleted }.count
        let progress = total > 0 ? Double(completed) / Double(total) : 0

        VStack(alignment: .leading) {
            Text("Overall Progress")
                .font(.subheadline)
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .brandAccent))
            Text("\(completed) of \(total) tasks completed")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    var taskViewModel: TaskViewModel = TaskViewModel()
    TaskProgressView().environmentObject(taskViewModel)
}
