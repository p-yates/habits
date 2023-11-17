//
//  HabitDetailView.swift
//  habits
//
//  Created by Paul Y on 2023-11-16.
//

import SwiftUI
import SwiftData

struct HabitDetailView: View {
    @Bindable var habit: Habit
    
    var body: some View {
        Spacer()
        HStack {
            Text("Goal: \(habit.goalValue)")
            Text(habit.goalUnits)
            }
        Spacer()
        NavigationLink(destination: EditHabitView(habit: habit)) {
            Text("Edit Habit")
            
        }.navigationTitle(Text("\(habit.name)"))
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let example = Habit(name: "Example habit", details: "lots of long text to overflow a line perhaps", icon: "pencil.circle", color: ".red", goalValue: 5, goalUnits: "Minutes", startDate: Date.now)
        return HabitDetailView(habit: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create model container")
    }
}
