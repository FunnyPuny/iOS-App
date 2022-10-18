// FrequencyView.swift
// Created by Zlata Guseva on 15.10.2022.

import UIKit

class FrequencyView: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = Texts.frequency
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(Day.allCases.map { DayView($0) })
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
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
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(stackView)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.greaterThanOrEqualTo(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
