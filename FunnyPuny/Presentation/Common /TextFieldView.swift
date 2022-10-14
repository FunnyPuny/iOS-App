// TextFieldView.swift
// Created by Zlata Guseva on 14.10.2022.

import UIKit

class TextFieldView: UIView {
    var text: String
    var placeholder: String

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = text
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.tintColor = .primaryText
        textField.backgroundColor = .white.withAlphaComponent(0.5)
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.primaryText?.cgColor
        textField.layer.borderWidth = CGFloat(1)
        return textField
    }()

    required init(text: String, placeholder: String) {
        self.text = text
        self.placeholder = placeholder
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
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(textField)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.greaterThanOrEqualTo(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
