// CalendarAnalyticHeaderView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarAnalyticHeaderView: JTACMonthReusableView {
    var monthView = CalendarAnalyticHeaderMonthView()

    var weekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(Frequency.allWeek.map { WeekdayView($0) })
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
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
    }

    private func addSubviews() {
        addSubview(monthView)
        addSubview(weekStackView)
    }

    private func makeConstraints() {
        monthView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(40)
        }

        weekStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(monthView.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
    }
}
