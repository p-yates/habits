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
    @State private var showingAlert = false
    @FocusState private var isTextFieldFocused: Bool

    
    var body: some View {
        Spacer()
        
        ZStack {
            //this is the circular progress bar
            CircularProgressBarView(progress: (Double(habit.goalProgress)/Double(habit.goalValue)))
                .padding(15)
                .accessibilityLabel("Habit progress bar")
                .accessibilityValue(String("Progress \(habit.goalProgress) out of \( habit.goalValue)"))

            //display the progress numerically and allow user updates
            VStack{
                VStack{
                    HStack {
                        Text("\(habit.goalProgress)").contentTransition(.numericText())
                        Text(habit.goalUnits)
                    }
                    .contentTransition(.numericText())
                    Text("/ \(habit.goalValue)")
                        .accessibilityLabel("Habit goal")
                }
                .accessibilityElement()
                .accessibilityLabel("Habit progress")
                .accessibilityValue(String("Progress \(habit.goalProgress) out of \( habit.goalValue)"))
                
                Stepper("", value: $habit.goalProgress)
                    .frame(width: 100, height: 100)
                    .accessibilityLabel("Update progress")

                //NOT IDEAL - hard coded size, should make it dynamic
            }
        }
        
        //let the user update the progress by entering a number rather than using the stepper
        HStack(spacing: 8) {
            TextField("Add progress", text: $progressToAdd)
                .keyboardType(.numberPad)
                .focused($isTextFieldFocused)
                .frame(width: 100)

            Button ("add", action: addProgress)
                .buttonStyle(.borderedProminent)
                .accessibilityLabel("Add progress")
        }
        .padding(.horizontal)

        
        Spacer()
        NavigationLink(destination: EditHabitView(habit: habit)) {
            Text("Edit Habit")
        }
        .navigationTitle(Text("\(habit.name)"))

        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Negative vlaue enterd"), message: Text("Please enter a positive value"), dismissButton: .default(Text("Okay")))
        }
        
    }
    
    func addProgress() {
        guard let progress = Int(progressToAdd) else { return }
        if  progress > 0 {
            habit.goalProgress += progress
        } else {
            showingAlert = true
        }
        isTextFieldFocused = false // Dismiss the keyboard
        progressToAdd = "" // Reset the input field
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
