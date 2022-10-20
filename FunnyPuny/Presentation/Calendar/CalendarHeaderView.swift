// CalendarHeaderView.swift
// Created by Zlata Guseva on 19.10.2022.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarHeaderView: JTACMonthReusableView {
    var monthTitle: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
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
        addSubview(monthTitle)
    }

    private func makeConstraints() {
        monthTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
