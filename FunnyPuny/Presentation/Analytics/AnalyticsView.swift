// AnalyticsView.swift
// FunnyPuny. Created by Zlata Guseva.

import SnapKit
import UIKit

class AnalyticsView: UIView {
    var menuButtonView = MenuButtonView()
    var achivmentView = AchivmentView()
    var calendarView = CalendarAnalyticView()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(menuButtonView)
        addSubview(achivmentView)
        addSubview(calendarView)
    }

    private func makeConstraints() {
        menuButtonView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
            make.leading.trailing.equalToSuperview()
        }

        achivmentView.snp.makeConstraints { make in
            make.top.equalTo(menuButtonView.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(76)
        }

        calendarView.snp.makeConstraints { make in
            make.top.equalTo(achivmentView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(364)
        }
    }
}

extension AnalyticsView: Configurable {
    func configure(with viewModel: AnalyticsViewModel) {
        achivmentView.completedScore.amountHabitsLabel.text = viewModel.completedScoreText
        achivmentView.missedScore.amountHabitsLabel.text = viewModel.missedScoreText

        achivmentView.progressView.statusLabel.text = String(Int(viewModel.statusValue * 100)) + "%"
        achivmentView.progressView.progressAnimation(value: viewModel.statusValue)

        menuButtonView.categoryLabel.text = viewModel.selectedHabit
        menuButtonView.makeMenu(with: viewModel.allHabitsName)
    }
}
