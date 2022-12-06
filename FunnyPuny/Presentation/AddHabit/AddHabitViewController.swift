// AddHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit
// swiftlint:disable all
class AddHabitViewController: ViewController, DayViewProtocolDelegate {
    func didSelect(index: Int?) {
        guard let index else { return }
        if index == 0 {
            addHabitViewModel.state = addHabitView.frequencyView.everydayLabel.isSelected ? .everyday : .specificDays
            addHabitView.configure(with: addHabitViewModel) // логика для евридей
        } else {
            addHabitViewModel.state = .specificDays
            addHabitView.configure(with: addHabitViewModel) // логика для вьюшек
        }
    }

    private var addHabitView = AddHabitView()
    private var addHabitViewModel = AddHabitViewModel(state: .everyday)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.addHabit
        view = addHabitView
        addHabitView.configure(with: addHabitViewModel)
        addHabitView.frequencyView.everydayLabel.delegate = self
        setupTargets()
        setupFrequency()
    }

    func setupFrequency() {
        let views = addHabitView.frequencyView.stackView.subviews as! [DayView]
        views.enumerated().forEach { index, view in
            view.index = index + 1
            view.delegate = self
        }
        addHabitView.frequencyView.everydayLabel.delegate = self
        addHabitView.frequencyView.everydayLabel.index = 0
    }

    private func setupTargets() {
        addHabitView.addButton.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
    }

    @objc
    func saveHabit() {
        let days = List<Frequency>()

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
