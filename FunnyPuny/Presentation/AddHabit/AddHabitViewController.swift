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
        setupFrequency()
        setupTargets()
        setupTextField()
    }

    func setupFrequency() {
        addHabitView.frequencyView.views.forEach { $0.delegate = self }
        addHabitView.frequencyView.everydayView.delegate = self
    }

    private func setupTargets() {
        addHabitView.addButton.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
    }

    func setupTextField() {
        addHabitView.nameInputView.textField.smartInsertDeleteType = .no
        addHabitView.nameInputView.textField.delegate = self
    }

    @objc
    func saveHabit() {
        let days = List<Frequency>()

        if addHabitViewModel.state == .everyday {
            let everyday: [Frequency] = [.mon, .tue, .wed, .thu, .fri, .sat, .sun]
            days.append(objectsIn: everyday)
        } else {
            for dayView in addHabitView.frequencyView.views where dayView.isSelected {
                days.append(dayView.day)
            }
        }

        do {
            try realm.write {
                let newHabit = Habit(
                    name: addHabitView.nameInputView.textField.text ?? "",
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
    func didSelect(_ day: Frequency) {
        if day == .everyday {
            addHabitViewModel.state = addHabitView.frequencyView.everydayView.isSelected ? .everyday : .specificDays
            for day in addHabitView.frequencyView.views {
                day.isSelected = false
            }
            // addHabitView.configure(with: addHabitViewModel)
        } else {
            addHabitViewModel.state = .specificDays
            // addHabitView.configure(with: addHabitViewModel)
        }
    }
}

// MARK: UITextFieldDelegate

extension AddHabitViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText)
        else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 25
    }
}
