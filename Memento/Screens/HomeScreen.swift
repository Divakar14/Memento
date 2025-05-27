//
//  HomeScreen.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    @EnvironmentObject var noteViewModel: NoteViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 25) {
                    Text("Welcome to Memento 👋🏻")
                        .font(.title2.bold())
                        .foregroundStyle(Color.brandAccent)
                    
                    TaskProgressView()
                    
                    SectionHeader(title: "In Progress Tasks")
                    ForEach(taskViewModel.tasks.filter { !$0.isCompleted }) { task in
                        TaskCard(task: task)
                    }
                    
                    SectionHeader(title: "Completed Tasks")
                    ForEach(taskViewModel.tasks.filter { $0.isCompleted }) { task in
                        TaskCard(task: task)
                    }
                    
                    SectionHeader(title: "Upcoming Tasks")
                    ForEach(taskViewModel.tasks.filter {
                        !$0.isCompleted && Calendar.current.isDateInToday($0.dueDate) == false
                    }) { task in
                        TaskCard(task: task)
                    }
                    
                    SectionHeader(title: "Saved Notes")
                    ForEach(noteViewModel.notes) { note in
                        NoteCard(note: note)
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct SectionHeader : View {
    var title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
            .padding(.top, 10)
    }
}

#Preview {
    var taskViewModel: TaskViewModel = TaskViewModel()
    var noteViewModel: NoteViewModel = NoteViewModel()
    HomeScreen().environmentObject(taskViewModel).environmentObject(noteViewModel)
}
