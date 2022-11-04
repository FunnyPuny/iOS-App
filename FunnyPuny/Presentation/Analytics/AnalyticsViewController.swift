// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()
    var history: Results<History>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = analyticsView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }

    func setupData() {
        analyticsView.commonAnalyticsView.completedScore.amountHabitsLabel.text = String(countCompletedHabits())
    }

    func countCompletedHabits() -> Int {
        history = realm.objects(History.self)
        var totalCount = 0
        if let history {
            for history in history {
                totalCount += history.habits.count
            }
        }
        return totalCount
    }
}
