// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()
//    var habits: Results<Habit>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = analyticsView
    }

//    func setupData() {
//        habits = realm.objects(Habit.self)
//    }
}
