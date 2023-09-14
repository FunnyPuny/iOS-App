// AddHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class AddHabitViewController: ViewController {
    enum EditMenuStyle {
        case delete
        case reset

        var title: String {
            switch self {
            case .delete:
                return Texts.deleteHabit
            case .reset:
                return Texts.resetProgress
            }
        }

        var descriptionMessage: String {
            switch self {
            case .delete:
                return Texts.askToDelete
            case .reset:
                return Texts.askToReset
            }
        }

        var actionTitle: String {
            switch self {
            case .delete:
                return Texts.delete
            case .reset:
                return Texts.reset
            }
        }
    }

    private let selectedFrequencies = List<Frequency>()
    private lazy var addHabitView = AddHabitView(stateView: habitStateView)
    private var habitManager = HabitManager()
    private var habitStateView: HabitStateView
    private var topMenu = UIMenu()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = habitStateView.label
        view = addHabitView
        selectedFrequencies.append(objectsIn: Frequency.allWeek)
        setupTargets()
        setupTextField()
        setupFrequency()
        leftItemBarSetup()
        if habitStateView != .add {
            rightItemBarSetup()
        }
    }

    init(habitStateView: HabitStateView) {
        self.habitStateView = habitStateView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        switch habitStateView {
        case .add:
            habitManager.saveHabit(
                name: addHabitView.nameInputView.textField.text ?? "",
                frequency: selectedFrequencies,
                createdDate: addHabitView.datePickerView.datePicker.date
            ) {
                dismissWithNotification()
            }
        case let .edit(habitName):
            habitManager.updateHabit(
                habitID: habitName.id,
                newName: addHabitView.nameInputView.textField.text ?? "",
                newFrequency: selectedFrequencies,
                newCreatedDate: addHabitView.datePickerView.datePicker.date
            ) {
                dismissWithNotification()
            }
        }
    }

    private func dismissWithNotification() {
        NotificationCenter.default.post(name: .habitDidAdd, object: nil)
        dismiss(animated: true)
    }

    private func dismissAfterReset() {
        NotificationCenter.default.post(name: .progressDidReset, object: nil)
        dismiss(animated: true)
    }

    private func rightItemBarSetup() {
        setupTopMenu()
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), menu: topMenu)
        rightItem.tintColor = Colors.iconsInactive.color
        navigationItem.rightBarButtonItems = [rightItem]
    }

    private func leftItemBarSetup() {
        let leftItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(closeTapped)
        )
        leftItem.tintColor = Colors.iconsInactive.color
        navigationItem.leftBarButtonItems = [leftItem]
    }

    @objc
    func closeTapped() {
        dismiss(animated: true)
    }

    private func setupTopMenu() {
        let deleteAction = UIAction(title: "Delete Habit") { [weak self] _ in
            self?.presentAlertInMenu(style: .delete)
        }

        let resetProgressAction = UIAction(title: "Reset progress") { [weak self] _ in
            self?.presentAlertInMenu(style: .reset)
        }
        topMenu = UIMenu(children: [deleteAction, resetProgressAction])
    }

    private func presentAlertInMenu(style: EditMenuStyle) {
        let story = UIAlertAction(title: style.actionTitle, style: .default) { [weak self] _ in
            switch self?.habitStateView {
            case let .edit(habitName):
                switch style {
                case .delete:
                    self?.habitManager.deleteHabitBy(habitName.id)
                case .reset:
                    self?.habitManager.resetProgressBy(habitName.id)
                }
                self?.dismissAfterReset()
            case .add, .none:
                break
            }
        }
        let alert = UIAlertController(title: style.title, message: style.descriptionMessage, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        alert.addAction(story)
        present(alert, animated: true)
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
