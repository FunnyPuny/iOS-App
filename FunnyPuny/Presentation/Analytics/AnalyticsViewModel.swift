// AnalyticsViewModel.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation

struct AnalyticsViewModel {
    var selectedHabit: String
    var completedScoreText: String
    var missedScoreText: String
    var percentValue: Float
    var allHabitsName: [String]

    init(selectedHabit: String, completedScore: Int, missedScore: Int, percentValue: Float, allHabitsName: [String]) {
        self.selectedHabit = selectedHabit
        completedScoreText = String(completedScore)
        missedScoreText = String(missedScore)
        self.percentValue = percentValue
        self.allHabitsName = allHabitsName
        self.allHabitsName.insert(Texts.allHabits, at: 0)
    }
}
