//
//  EditHabitView.swift
//  habits
//
//  Created by Paul Y on 2023-11-15.
//

import SwiftUI
import SwiftData

struct EditHabitView: View {
    @Bindable var habit: Habit
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        Form {
            TextField("Name", text: $habit.name)
                .accessibilityLabel("Habit Name")
            TextField("Details", text: $habit.details)
                .accessibilityLabel("Habit Details")
            TextField("Icon", text: $habit.icon)
            //this should force opening an emoji picker really
                .accessibilityLabel("Habit Emoji Icon")
            Stepper("Enter goal value: \(habit.goalValue)", value: $habit.goalValue, in: 0...1000)
                .accessibilityLabel("Input Habit progress")
            TextField("Goal Units", text: $habit.goalUnits)
                .accessibilityLabel("Habit goal units")
            DatePicker("Start Date", selection: $habit.startDate, displayedComponents: .date)
                .accessibilityLabel("Habit Start Date")
            DatePicker("End Date", selection: $habit.endDate, displayedComponents: .date)
                .accessibilityLabel("Habit End Date")
        }
        .navigationTitle("Edit habit")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let example = Habit(name: "Example habit", details: "lots of long text to overflow a line perhaps", icon: "pencil.circle", color: ".red", goalValue: 5, goalUnits: "Minutes", startDate: Date.now)
        return EditHabitView(habit: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create model container")
    }
}
