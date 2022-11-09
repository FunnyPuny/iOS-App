// CalendarAnalyticHeaderView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarAnalyticHeaderView: UIView {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .vividPink
        label.font = .bold24
        label.textAlignment = .center
        label.text = Date().string(dateFormat: .formatMMMMyyyy)
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
        }
    }
}
