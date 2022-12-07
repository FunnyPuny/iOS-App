// AddHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class AddHabitViewController: ViewController {
    private var addHabitView = AddHabitView()
    private var addHabitViewModel = AddHabitViewModel(state: .everyday)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.addHabit
        view = addHabitView
        addHabitView.configure(with: addHabitViewModel)
        addHabitView.frequencyView.everydayView.delegate = self
        setupTargets()
        setupFrequency()
    }

    func setupFrequency() {
        let views = addHabitView.frequencyView.views
        views.enumerated().forEach { index, view in
            view.index = index + 1
            view.delegate = self
        }
        addHabitView.frequencyView.everydayView.delegate = self
        addHabitView.frequencyView.everydayView.index = 0
    }

    private func setupTargets() {
        addHabitView.addButton.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
    }

    @objc
    func saveHabit() {
        let days = List<Frequency>()
        // TODO: 💩
        if addHabitViewModel.state == .everyday {
            var currentDays = Frequency.allCases
            currentDays.removeLast()
            days.append(objectsIn: currentDays)
        } else {
            for dayView in addHabitView.frequencyView.views {
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

// MARK: DayViewProtocolDelegate

extension AddHabitViewController: DayViewProtocolDelegate {
    func dayDidSelect(index: Int?) {
        guard let index else { return }
        if index == 0 {
            addHabitViewModel.state = addHabitView.frequencyView.everydayView.isSelected ? .everyday : .specificDays
            for day in addHabitView.frequencyView.views {
                day.isSelected = false
            }
            addHabitView.configure(with: addHabitViewModel)
        } else {
            addHabitViewModel.state = .specificDays
            addHabitView.configure(with: addHabitViewModel)
        }
    }
}
