// AchivmentView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class AchivmentView: UIView {
    var progressView: ProgressView = {
        let progressView = ProgressView(frame: CGRect(x: 10.0, y: 10.0, width: 50.0, height: 50.0))
        progressView.trackColor = Asset.Colors.backgroundBoarder.color
        progressView.progressColor = Colors.backgroundAccent.color
        return progressView
    }()

    var completedScore = ScoreView(amount: "", text: Texts.completed)
    var missedScore = ScoreView(amount: "", text: Texts.missed)

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(completedScore)
        stackView.addArrangedSubview(missedScore)
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
        backgroundColor = Colors.backgroundGlobe.color
        layer.cornerRadius = 16
        layer.borderColor = Colors.backgroundIsland.color.cgColor
        layer.borderWidth = 1
    }

    private func addSubviews() {
        addSubview(progressView)
        addSubview(stackView)
    }

    private func makeConstraints() {
        progressView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(progressView.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
    }
}
