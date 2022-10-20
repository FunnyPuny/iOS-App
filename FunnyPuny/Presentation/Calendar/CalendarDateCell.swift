// CalendarDateCell.swift
// Created by Zlata Guseva on 19.10.2022.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarDateCell: JTACDayCell {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 24)
        label.backgroundColor = .foreground
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
        addSubview(dateLabel)
    }

    private func makeConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
    }
}
