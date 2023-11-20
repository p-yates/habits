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
    @State var progressToAdd: String = ""
    
    var body: some View {
        Spacer()
        
        ZStack {
            CircularProgressBarView(progress: (Double(habit.goalProgress)/Double(habit.goalValue)))
                .padding(15)
            VStack{
                HStack {
                    Text("Goal: \(habit.goalValue)")
                    Text(habit.goalUnits)
                }
                Text("Goal Progress: \(habit.goalProgress)")
                Stepper("", value: $habit.goalProgress)
                    .frame(width: 100, height: 100)
                //NOT IDEAL - hard coded size, should make it dynamic
            }
        }
        
        //let the user update the progress by entering a number rather than using the stepper
        Spacer()
        
        HStack(spacing: 8) {
            TextField("Add progress", text: $progressToAdd)
                .keyboardType(.numberPad)
                .frame(width: 100)
            Button ("add", action: addProgress)
                .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
        
        Spacer()
        NavigationLink(destination: EditHabitView(habit: habit)) {
            Text("Edit Habit")
            
        }.navigationTitle(Text("\(habit.name)"))
    }
    
    
    func addProgress() {
        guard let progress = Int(progressToAdd) else { return }
        habit.goalProgress += progress
        progressToAdd = "" // Reset the input field
        print(progress)
        print(habit.goalProgress)
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
