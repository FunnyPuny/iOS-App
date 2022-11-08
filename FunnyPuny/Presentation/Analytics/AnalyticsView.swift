// AnalyticsView.swift
// FunnyPuny. Created by Zlata Guseva.

import SnapKit
import UIKit

class AnalyticsView: UIView {
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .foreground
        label.font = .bold17
        label.text = Texts.allHabits
        return label
    }()

    var commonAnalyticsView = AchivmentView()

    var calendarView: CalendarAnalyticView = {
        let view = CalendarAnalyticView()
        return view
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
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .background
    }

    private func addSubviews() {
        addSubview(categoryLabel)
        addSubview(commonAnalyticsView)
        addSubview(calendarView)
    }

    private func makeConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }

        commonAnalyticsView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(76)
        }

        calendarView.snp.makeConstraints { make in
            make.top.equalTo(commonAnalyticsView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(332)
        }
    }
}
