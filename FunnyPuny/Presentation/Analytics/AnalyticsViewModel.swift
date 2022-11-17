// AnalyticsViewModel.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation

struct AnalyticsViewModel {
    var completedScoreText: String
    var missedScoreText: String
    var statusText: String
    var allHabitsName: [String]

    init(completedScore: Int, missedScore: Int, statusValue: Float, allHabitsName: [String]) {
        completedScoreText = String(completedScore)
        missedScoreText = String(missedScore)
        statusText = String(Int(statusValue * 100)) + "%"
        self.allHabitsName = allHabitsName
        // TODO: append [0] all habits
    }
}
