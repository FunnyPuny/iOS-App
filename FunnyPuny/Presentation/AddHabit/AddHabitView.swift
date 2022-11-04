// AddHabitView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class AddHabitView: UIView {
    var nameInputView = TextFieldView(text: Texts.name, placeholder: Texts.nameHabit)
    var reminderInputView = TextFieldView(text: Texts.reminderNote, placeholder: Texts.note)
    var frequencyView = FrequencyView()
    var reminderTimeView = ReminderTimeView()

    var addButtonView: UIButton = {
        let button = UIButton()
        button.setTitle(Texts.add, for: .normal)
        button.titleLabel?.textColor = .background
        button.titleLabel?.font = .regular17
        button.backgroundColor = .mainGrey
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
        addSubview(addButtonView)
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

        addButtonView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(66)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }

    private func setupTargets() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
}
