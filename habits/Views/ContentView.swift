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
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(habits) { habit in
                    NavigationLink(value: habit) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(habit.icon)
                                Text(habit.name)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteHabit)
            }
            .navigationTitle("Habits ✔️")
            .navigationDestination(for: Habit.self, destination: EditHabitView.init)
            .toolbar {
                Button("Add habit", systemImage: "plus", action: addHabit)
            } //this should be in a tab bar later
        }
        
    }
    
    func addHabit() {
        let habit = Habit()
        modelContext.insert(habit)
        path = [habit]
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
