//
//  HabitModel.swift
//  habits
//
//  Created by Paul Y on 2023-11-15.
//

import SwiftUI
import SwiftData

@Model
class Habit {
    var name: String
    var details: String
    var icon: String
    var color: String
    var goalValue: Int
    var goalUnits: String
    var startDate: Date
    var endDate: Date
    var goalProgress: Int
    // var reminderTime:
    
    
    init(name: String = "", details: String = "", icon: String = "✔️", color: String = "", goalValue: Int = 10, goalUnits: String = "", startDate: Date = .now, endDate: Date = .now, goalProgress: Int = 1 ) {
        self.name = name
        self.details = details
        self.icon = icon
        self.color = color
        self.goalValue = goalValue
        self.goalUnits = goalUnits
        self.startDate = startDate
        self.endDate = endDate
        self.goalProgress = goalProgress
    }
}
