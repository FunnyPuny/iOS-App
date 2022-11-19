// AddHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class AddHabitViewController: ViewController {
    private var addHabitView = AddHabitView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.addHabit
        view = addHabitView
        setupTargets()
    }

    private func setupTargets() {
        addHabitView.addButton.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
    }

    @objc
    func saveHabit() {
        let days = List<Frequency>()
        // swiftlint:disable all
        // TODO: 💩
        if addHabitView.frequencyView.viewState == .everyday {
            days.append(objectsIn: Frequency.allCases)
        } else {
            for dayView in addHabitView.frequencyView.stackView.arrangedSubviews as! [DayView] {
                if dayView.isSelected {
                    days.append(dayView.day)
                }
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
