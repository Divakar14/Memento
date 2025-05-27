//
//  MementoTabView.swift
//  Memento
//
//  Created by Divakar T R on 23/05/25.
//

import SwiftUI

struct MementoTabView: View {
    
    @State private var showModal: Bool = false
    @State private var showCreateTask: Bool = false
    @State private var showCreateNote: Bool = false
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @StateObject var noteViewModel: NoteViewModel = NoteViewModel()
    
    enum Tab {
        case home, calendar, profile
    }
    
    @State private var selectedTab : Tab = .home
    
    var body: some View {
        
        ZStack {
            
            Color(.brandSecondary).ignoresSafeArea()
            
            VStack {
                switch selectedTab {
                case .home:
                    HomeScreen().environmentObject(taskViewModel).environmentObject(noteViewModel)
                case .calendar:
                    Text("Calendar Screen").foregroundStyle(.black)
                case .profile:
                    Text("Profile Screen").foregroundStyle(.black)
                }
//                Spacer()
            }
            
            VStack {
                Spacer()
                ZStack {
                    HStack {
                        tabButton(icon: "house", tab: .home, title: "Home")
//                        tabButton(icon: "text.page", tab: .notes, title: "Notes")
//                        Spacer().frame(width: 80)
                        tabButton(icon: "calendar", tab: .calendar, title: "Calendar")
                        tabButton(icon: "person", tab: .profile, title: "Profile")
                        Button {
                            withAnimation {
                                showModal = true
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundStyle(Color(.brandAccent))
                                .background(Circle().fill(Color(.brandHighlight)))
                        }
                        .offset(y: -3)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.brandPrimary).opacity(0.9))
                            .shadow(radius: 5)
                    )
                    .padding(.horizontal)
                    
                }
                .customModal(isPresented: $showModal) {
                    VStack (spacing: 20) {
                        Text("What would you like to create!?")
                            .font(.headline)
                            .padding(.top)
                        Button(action: {
                            showCreateTask = true
                            showModal = false
                        }) {
                            Label("New Task", systemImage: "checkmark.square.fill")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.brandPrimary))
                                .foregroundColor(Color(.brandHighlight))
                                .cornerRadius(12)
                        }
                        Button(action: {
                            showCreateNote = true
                            showModal = false
                        }) {
                            Label("New Note", systemImage: "text.page")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.brandPrimary))
                                .foregroundColor(Color(.brandHighlight))
                                .cornerRadius(12)
                        }
                        Button {
                            withAnimation {
                                showModal = false
                            }
                        } label: {
                            Text("Cancel")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.brandPrimary))
                                .foregroundColor(Color(.brandAccent))
                                .cornerRadius(12)
                        }
                        .padding(.bottom)
                    }
                    .padding()
                }
                .fullScreenCover(isPresented: $showCreateTask) {
                    CreateTaskView().environmentObject(taskViewModel)
                }
                .fullScreenCover(isPresented: $showCreateNote) {
                    CreateNoteView().environmentObject(noteViewModel)
                }
            }
        }
        
    }
    
    func tabButton(icon: String, tab: Tab, title: String) -> some View {
        VStack (spacing: 3) {
            Button {
                selectedTab = tab
            } label: {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(selectedTab == tab ? .brandHighlight : .brandSecondary.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(selectedTab == tab ? .brandHighlight : .brandSecondary.opacity(0.7))
        }

    }
    
}

#Preview {
    MementoTabView()
}
