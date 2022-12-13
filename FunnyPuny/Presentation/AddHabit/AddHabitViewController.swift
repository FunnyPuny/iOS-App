// AddHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class AddHabitViewController: ViewController {
    private var addHabitView = AddHabitView()
    private let selectedFrequencies = List<Frequency>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.addHabit
        view = addHabitView
        setupTargets()
        setupTextField()
        setupFrequency()
    }

    private func setupTargets() {
        addHabitView.addButton.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
    }

    private func setupTextField() {
        addHabitView.nameInputView.textField.smartInsertDeleteType = .no
        addHabitView.nameInputView.textField.delegate = self
    }

    private func setupFrequency() {
        addHabitView.frequencyView.delegate = self
    }

    @objc
    func saveHabit() {
        do {
            try realm.write {
                let newHabit = Habit(
                    name: addHabitView.nameInputView.textField.text ?? "",
                    frequency: selectedFrequencies
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

// MARK: FrequencyViewDelegate

extension AddHabitViewController: FrequencyViewDelegate {
    func didSelect(_ frequencies: [Frequency]) {
        selectedFrequencies.append(objectsIn: frequencies)
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
