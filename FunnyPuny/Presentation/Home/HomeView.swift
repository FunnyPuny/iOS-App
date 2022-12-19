// HomeView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class HomeView: UIView {
    var calendarView: CalendarHomeView = {
        let view = CalendarHomeView()
        return view
    }()

    var emptyViewState = HomeStateView(
        titleText: Texts.emptyStateTitle,
        labelText: Texts.emptyStateLabel,
        gifImageView: .emptyStateGIF
    )

    var chillViewState = HomeStateView(
        titleText: Texts.chillStateTitle,
        labelText: Texts.chillStateLabel,
        gifImageView: .chillStateGIF
    )

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.backgroundGlobe.color
        tableView.register(cellWithClass: HomeCell.self)
        tableView.rowHeight = 86
        tableView.separatorStyle = .none
        return tableView
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
        backgroundColor = Colors.backgroundGlobe.color
    }

    private func addSubviews() {
        addSubview(tableView)
        addSubview(calendarView)
        addSubview(emptyViewState)
        addSubview(chillViewState)
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

        emptyViewState.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }

        chillViewState.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
}

extension HomeView: Configurable {
    func configure(with state: HomeViewController.ViewState) {
        switch state {
        case .emptyState:
            emptyViewState.isHidden = false
            chillViewState.isHidden = true
            tableView.isHidden = true
        case .chillState:
            emptyViewState.isHidden = true
            chillViewState.isHidden = false
            tableView.isHidden = true
        case .regularState:
            emptyViewState.isHidden = true
            chillViewState.isHidden = true
            tableView.isHidden = false
        }
    }
}
