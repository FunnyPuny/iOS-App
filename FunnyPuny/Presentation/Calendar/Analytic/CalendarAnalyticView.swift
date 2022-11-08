// CalendarAnalyticView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarAnalyticView: UIView {
    var headerView: CalendarAnalyticHeaderView = {
        let view = CalendarAnalyticHeaderView()
        return view
    }()

    var monthView: JTACMonthView = {
        let view = JTACMonthView()
        view.register(CalendarAnalyticDateCell.self, forCellWithReuseIdentifier: "CalendarAnalyticDateCell")
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.vividPink?.cgColor
        layer.cornerRadius = 16
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
            make.height.equalTo(260)
        }
    }
}
