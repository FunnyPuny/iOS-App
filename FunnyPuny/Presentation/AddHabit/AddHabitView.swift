// AddHabitView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class AddHabitView: UIView {
    var nameInputView = TextFieldView(text: Texts.name, placeholder: Texts.nameHabit)
    var reminderInputView = TextFieldView(text: Texts.reminderNote, placeholder: Texts.note)
    var frequencyView: FrequencyView = {
        let view = FrequencyView()
        view.viewState = .everyday
        return view
    }()

    private var reminderTimeView = ReminderTimeView()

    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle(Texts.add, for: .normal)
        button.titleLabel?.textColor = Colors.textSecondary.color
        button.titleLabel?.font = .regular20
        button.backgroundColor = Colors.buttonInactive.color
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 12
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
        setupTargets()
    }

    private func addSubviews() {
        addSubview(nameInputView)
        addSubview(reminderInputView)
        addSubview(frequencyView)
        addSubview(reminderTimeView)
        addSubview(addButton)
    }

    private func makeConstraints() {
        nameInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
        }

        reminderInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nameInputView.snp.bottom).offset(24)
        }

        frequencyView.snp.makeConstraints { make in
            make.top.equalTo(reminderInputView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        reminderTimeView.snp.makeConstraints { make in
            make.top.equalTo(frequencyView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
        }

        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(66)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }

    private func setupTargets() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        nameInputView.textField.addTarget(
            self,
            action: #selector(textFieldDidChange),
            for: UIControl.Event.editingChanged
        )
    }

    @objc func textFieldDidChange(_: UITextField) {
        addButton.backgroundColor = nameInputView.textField.isValid(with: " ")
            ? Colors.buttonActive.color
            : Colors.buttonInactive.color
        addButton.titleLabel?.textColor = nameInputView.textField.isValid(with: " ")
            ? Colors.textPrimaryInverse.color
            : Colors.textSecondary.color
    }
}
