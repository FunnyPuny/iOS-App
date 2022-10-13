// AddNewHabitView.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class AddNewHabitView: UIView {
    lazy var nameInputView: InputView = {
        let inputView = InputView()
        inputView.label.text = "Name"
        inputView.textField.placeholder = "Name habit"
        return inputView
    }()

    lazy var reminderInputView: InputView = {
        let inputView = InputView()
        inputView.label.text = "Reminder Note"
        inputView.textField.placeholder = "Note"
        return inputView
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
    }

    private func addSubviews() {
        addSubview(nameInputView)
        addSubview(reminderInputView)
    }

    private func makeConstraints() {
        nameInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(128)
        }

        reminderInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nameInputView.snp.bottom).offset(32)
        }
    }
}
