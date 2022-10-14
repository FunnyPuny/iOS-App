// AddHabitViewController.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class AddHabitViewController: ViewController {
    private var addHabitView = AddHabitView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.addHabit
        view = addHabitView
        setupNavigation()
    }

    private func setupNavigation() {
        let addNavigationItem = UIBarButtonItem(
            title: Texts.add,
            style: .plain,
            target: self,
            action: #selector(saveHabit)
        )
        navigationItem.rightBarButtonItem = addNavigationItem
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    @objc
    func saveHabit() {
        dismiss(animated: true)

        var days: [Day] = []
        // swiftlint:disable all
        // TODO: избавиться от force cast
        for dayView in addHabitView.frequencyView.stackView.arrangedSubviews as! [DayView] {
            if dayView.isSelected {
                days.append(dayView.day)
            }
        }
    }
}
