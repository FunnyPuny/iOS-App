// DatePickerView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class DatePickerView: UIView {
    var text: String

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = text
        label.textColor = Colors.textPrimary.color
        label.font = .bodyMedium
        return label
    }()

    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.tintColor = Colors.backgroundAccent.color
        return datePicker
    }()

    required init(text: String) {
        self.text = text
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
        backgroundColor = Colors.backgroundGlobe.color
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
            make.top.equalTo(label.snp.bottom).offset(12)
            make.height.equalTo(40)
            make.leading.bottom.equalToSuperview()
        }
    }
}
