//
//  ContentView.swift
//  habits
//
//  Created by Paul Y on 2023-11-15.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    @State private var path = [Habit]()
    @State private var showEdit = false
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(habits) { habit in
                    NavigationLink(value: habit) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(habit.icon)
                                Text(habit.name)
                                Spacer ()
                                Text("\(habit.goalProgress) / \(habit.goalValue) \(habit.goalUnits) ")
                            }
                        }


                    }
                    //.listRowBackground(habit.color) colour property is not set right so this doesn't work
                    .listRowBackground(habit.goalProgress >= habit.goalValue ? Color.green.opacity(0.2) : Color.clear)
                }
                
                .onDelete(perform: deleteHabit)
                .onAppear {
                    showEdit = false
                }
            }
            .navigationTitle("Habits")
            .navigationDestination(for: Habit.self, destination: { habit in
                if showEdit {
                    EditHabitView(habit: habit)
                } else {
                    HabitDetailView(habit: habit)
                }
            })
            .toolbar {
                Button("Add habit", systemImage: "plus") {
                    addHabit()
                }
            } //this should be in a tab bar later
        }
    }
    
    func addHabit() {
        let habit = Habit()
        modelContext.insert(habit)
        path = [habit]
        showEdit = true
    }
    
    func deleteHabit(_ indexSet: IndexSet) {
        for index in indexSet {
            let habit = habits[index]
            modelContext.delete(habit)
        }
    }
}

#Preview {
    ContentView()
}
