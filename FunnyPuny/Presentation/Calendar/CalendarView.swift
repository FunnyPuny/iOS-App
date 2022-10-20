// CalendarView.swift
// Created by Zlata Guseva on 20.10.2022.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarView: UIView {
    var headerView: CalendarHeaderView = {
        let view = CalendarHeaderView()
        return view
    }()

    var monthView: JTACMonthView = {
        let view = JTACMonthView()
        view.register(CalendarDateCell.self, forCellWithReuseIdentifier: "CalendarDateCell")
        view.backgroundColor = .background
        view.scrollDirection = .horizontal
        view.showsHorizontalScrollIndicator = false
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
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(headerView)
        addSubview(monthView)
    }

    private func makeConstraints() {
        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(50)
        }

        monthView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(16)
        }
    }
}
