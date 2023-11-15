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
    
    var body: some View {
        
        Form {
            TextField("Name", text: $habit.name)
            TextField("Details", text: $habit.details)
        }
        .navigationTitle("Edit habit")
        .navigationBarTitleDisplayMode(.inline)
    }

}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let example = Habit(name: "Example habit", details: "lots of long text to overflow a line perhaps", icon: "pencil.circle", color: ".red", goalValue: 5, goalUnits: "Minutes")
        return EditHabitView(habit: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create model container")
    }
}
