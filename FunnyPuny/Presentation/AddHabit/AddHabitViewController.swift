// AddHabitViewController.swift
// Created by Zlata Guseva on 13.10.2022.

import RealmSwift
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
        let days = List<Day>()
        // swiftlint:disable all
        // TODO: 💩
        for dayView in addHabitView.frequencyView.stackView.arrangedSubviews as! [DayView] {
            if dayView.isSelected {
                days.append(dayView.day)
            }
        }
        do {
            try realm.write {
                let newHabit = Habit(
                    name: addHabitView.nameInputView.textField.text ?? "",
                    note: addHabitView.reminderInputView.textField.text ?? "",
                    frequency: days
                )
                realm.add(newHabit)
                NotificationCenter.default.post(name: .habitDidAdd, object: nil)
                dismiss(animated: true)
            }
        } catch let error as NSError {
            print("Can not create habit, error: \(error)")
        }
    }
}
