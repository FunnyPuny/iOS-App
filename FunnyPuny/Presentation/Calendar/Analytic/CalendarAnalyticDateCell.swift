// CalendarAnalyticDateCell.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarAnalyticDateCell: JTACDayCell {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .foreground
        label.font = .regular14
        label.backgroundColor = .background
        label.layer.borderColor = UIColor.greyLight?.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.layer.cornerRadius = 18
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
            make.edges.equalToSuperview()
            make.size.equalTo(36)
        }
    }
}
