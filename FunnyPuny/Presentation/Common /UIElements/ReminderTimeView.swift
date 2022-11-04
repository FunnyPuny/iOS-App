// ReminderTimeView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class ReminderTimeView: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = Texts.reminderTime
        label.textColor = .foreground
        label.font = .regular20
        return label
    }()

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        // datePicker.preferredDatePickerStyle = .automatic
        // datePicker.subviews[0].backgroundColor = .vividPink // TODO:
        datePicker.subviews[0].layer.borderColor = UIColor.mainGrey?.cgColor
        datePicker.subviews[0].layer.borderWidth = 1
        datePicker.subviews[0].layer.cornerRadius = 10
        return datePicker
    }()

    required init() {
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .background
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(datePicker)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }

        datePicker.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.height.equalTo(100)
            make.width.equalTo(300)
            make.leading.equalToSuperview()
        }
    }
}
