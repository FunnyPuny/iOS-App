// EditingHabitView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class EditingHabitView: UIView {
    var habit: Habit
    private lazy var nameInputView = TextFieldView(text: Texts.name, placeholder: habit.name)
    private var frequencyView = FrequencyView()

    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(Texts.delete, for: .normal)
        button.setTitleColor(Colors.textFalse.color, for: .normal)
        button.titleLabel?.font = .bodyRegular
        button.backgroundColor = Colors.buttonInactive.color
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 12
        return button
    }()

    required init(habit: Habit) {
        self.habit = habit
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
        setupStyle()
    }

    private func addSubviews() {
        addSubview(nameInputView)
        addSubview(frequencyView)
        addSubview(deleteButton)
    }

    private func makeConstraints() {
        nameInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
        }

        frequencyView.snp.makeConstraints { make in
            make.top.equalTo(nameInputView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        deleteButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(66)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }

    private func setupStyle() {
        nameInputView.textField.attributedPlaceholder = NSAttributedString(
            string: habit.name,
            attributes: [.foregroundColor: Colors.textPrimary.color]
        )
    }
}
