// HomeView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class HomeView: UIView {
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundGlobe
        tableView.register(cellWithClass: HomeCell.self)
        tableView.rowHeight = 86
        tableView.separatorStyle = .none
        return tableView
    }()

    var calendarView: CalendarHomeView = {
        let view = CalendarHomeView()
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
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .backgroundGlobe
    }

    private func addSubviews() {
        addSubview(tableView)
        addSubview(calendarView)
    }

    private func makeConstraints() {
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(148)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
