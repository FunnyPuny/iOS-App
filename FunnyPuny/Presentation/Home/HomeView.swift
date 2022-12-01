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

    var emptyImageView = HomeViewState(
        titleText: Texts.emptyStateTitle,
        labelText: Texts.emptyStateLabel,
        gifImageView: .emptyStateGIF
    )

    var chillImageView = HomeViewState(
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
        addSubview(emptyImageView)
        addSubview(chillImageView)
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

        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }

        chillImageView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
}

extension HomeView: Configurable {
    func configure(with viewModel: HomeViewModel) {
        switch viewModel.homeViewState {
        case .emptyState:
            emptyImageView.isHidden = false
            chillImageView.isHidden = true
            tableView.isHidden = true
        case .chillState:
            emptyImageView.isHidden = true
            chillImageView.isHidden = false
            tableView.isHidden = true
        case .regularState:
            emptyImageView.isHidden = true
            chillImageView.isHidden = true
            tableView.isHidden = false
        }
    }
}
