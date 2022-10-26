// CalendarDateCell.swift
// Created by Zlata Guseva on 19.10.2022.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarDateCell: JTACDayCell {
    var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .background
        label.layer.borderColor = UIColor.mainText?.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.layer.cornerRadius = 9
        label.clipsToBounds = true
        return label
    }()

    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackText
        label.font = .init(name: "SF-Pro", size: 12)
        label.backgroundColor = .background
        label.layer.borderColor = UIColor.primaryText?.cgColor
        label.layer.borderWidth = 2
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        return label
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
        addSubview(dayOfWeekLabel)
        addSubview(dateLabel)
    }

    private func makeConstraints() {
        dayOfWeekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(18)
        }

        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(40)
        }
    }
}
