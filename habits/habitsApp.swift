//
//  habitsApp.swift
//  habits
//
//  Created by Paul Y on 2023-11-15.
//

import SwiftUI
import SwiftData

@main
struct habitsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Habit.self)
    }
}
