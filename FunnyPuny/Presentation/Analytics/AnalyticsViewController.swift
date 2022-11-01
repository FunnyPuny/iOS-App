// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

// swiftlint:disable all
class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = analyticsView
    }
}
