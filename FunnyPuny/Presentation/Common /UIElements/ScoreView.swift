// ScoreView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class ScoreView: UIView {
    private var amount: String
    private var text: String

    lazy var amountHabitsLabel: UILabel = {
        let label = UILabel()
        label.text = amount
        label.textAlignment = .center
        label.textColor = Colors.textPrimary.color
        label.font = .bodyRegular
        return label
    }()

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = Colors.textPrimary.color
        label.font = .body
        return label
    }()

    required init(amount: String, text: String) {
        self.amount = amount
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
        addSubview(amountHabitsLabel)
        addSubview(textLabel)
    }

    private func makeConstraints() {
        amountHabitsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }

        textLabel.snp.makeConstraints { make in
            make.top.equalTo(amountHabitsLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}

extension ScoreView {
    func configure(scoreText: String) {
        amountHabitsLabel.text = scoreText
    }
}
