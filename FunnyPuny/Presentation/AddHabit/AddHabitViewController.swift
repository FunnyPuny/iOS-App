// AddHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class AddHabitViewController: ViewController {
    private var addHabitView = AddHabitView()
    private let selectedFrequencies = List<Frequency>()
    private var habitManager = HabitManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.addHabit
        view = addHabitView
        selectedFrequencies.append(objectsIn: Frequency.allWeek)
        setupTargets()
        setupTextField()
        setupFrequency()
    }

    private func setupTargets() {
        addHabitView.addButton.addTarget(self, action: #selector(addButtonDidPressed), for: .touchUpInside)
    }

    private func setupTextField() {
        addHabitView.nameInputView.textField.smartInsertDeleteType = .no
        addHabitView.nameInputView.textField.delegate = self
    }

    private func setupFrequency() {
        addHabitView.frequencyView.delegate = self
    }

    @objc
    private func addButtonDidPressed() {
        if addHabitView.frequencyView.selectedFrequencies.isEmpty, !addHabitView.nameInputView.textField.isValid {
            presentAlert(message: Texts.addAllItems)
        } else if addHabitView.frequencyView.selectedFrequencies.isEmpty, addHabitView.nameInputView.textField.isValid {
            presentAlert(message: Texts.addFrequency)
        } else if
            !addHabitView.frequencyView.selectedFrequencies.isEmpty,
            !addHabitView.nameInputView.textField.isValid
        {
            presentAlert(message: Texts.addName)
        } else {
            saveHabit()
        }
    }

    private func saveHabit() {
        habitManager.saveHabit(name: addHabitView.nameInputView.textField.text ?? "", frequency: selectedFrequencies) {
            NotificationCenter.default.post(name: .habitDidAdd, object: nil)
            dismiss(animated: true)
        }
    }
}

// MARK: FrequencyViewDelegate

extension AddHabitViewController: FrequencyViewDelegate {
    func didSelect(_ frequencies: [Frequency]) {
        selectedFrequencies.removeAll()
        if frequencies.contains(.everyday) {
            selectedFrequencies.append(objectsIn: Frequency.allWeek)
        } else {
            selectedFrequencies.append(objectsIn: frequencies)
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
