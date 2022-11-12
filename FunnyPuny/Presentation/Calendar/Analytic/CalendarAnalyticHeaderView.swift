// CalendarAnalyticHeaderView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarAnalyticHeaderView: JTACMonthReusableView {
    var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .foreground
        label.font = .regular17
        label.textAlignment = .center
        return label
    }()

    var weekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(WeekdayView(.sun))
        stackView.addArrangedSubview(WeekdayView(.mon))
        stackView.addArrangedSubview(WeekdayView(.tue))
        stackView.addArrangedSubview(WeekdayView(.wed))
        stackView.addArrangedSubview(WeekdayView(.thu))
        stackView.addArrangedSubview(WeekdayView(.fri))
        stackView.addArrangedSubview(WeekdayView(.sat))
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
        addSubview(monthLabel)
        addSubview(weekStackView)
    }

    private func makeConstraints() {
        monthLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(40)
        }
        weekStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(monthLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
    }
}
