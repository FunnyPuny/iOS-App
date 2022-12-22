// DayOfWeekView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class WeekdayView: UIView {
    var weekday: Frequency
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.text = weekday.string[0]
        label.textColor = Colors.textSecondary.color
        label.font = .caption
        label.textAlignment = .center
        return label
    }()

    required init(_ weekday: Frequency) {
        self.weekday = weekday
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
        addSubview(weekdayLabel)
    }

    private func makeConstraints() {
        weekdayLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
