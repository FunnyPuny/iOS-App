// CalendarHomeView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarHomeView: UIView {
    var headerView: CalendarHomeHeaderView = {
        let view = CalendarHomeHeaderView()
        return view
    }()

    var monthView: JTACMonthView = {
        let view = JTACMonthView()
        view.register(CalendarHomeDateCell.self, forCellWithReuseIdentifier: "CalendarHomeDateCell")
        view.backgroundColor = Colors.backgroundGlobe.color
        view.scrollDirection = .horizontal
        view.scrollingMode = .none
        view.showsHorizontalScrollIndicator = false
        view.cellSize = UIScreen.main.bounds.width / 7
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
            make.height.equalTo(60)
        }

        monthView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(88)
        }
    }
}
