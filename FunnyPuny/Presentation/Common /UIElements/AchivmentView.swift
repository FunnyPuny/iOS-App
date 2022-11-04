// AchivmentView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class AchivmentView: UIView {
    var statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .pinkLight
        return view
    }()

    lazy var completedScore = ScoreView(amount: "72", text: Texts.completed)
    lazy var missedScore = ScoreView(amount: "28", text: Texts.missed)

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(completedScore)
        stackView.addArrangedSubview(missedScore)
        stackView.addSeparators(at: [1], color: .lightGray)
        stackView.distribution = .fillProportionally
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
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .background
        layer.cornerRadius = 16
        layer.borderColor = UIColor.pinkLight?.cgColor
        layer.borderWidth = 1
    }

    private func addSubviews() {
        addSubview(statusView)
        addSubview(stackView)
    }

    private func makeConstraints() {
        statusView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(statusView.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
    }
}
