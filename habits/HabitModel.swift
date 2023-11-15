//
//  HabitModel.swift
//  habits
//
//  Created by Paul Y on 2023-11-15.
//

import Foundation

struct  Habit: Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var icon: String
    var color: String
    var goalValue: Int
    var goalUnits: String
   // var reminderTime:
}
