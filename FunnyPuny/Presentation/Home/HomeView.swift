// HomeView.swift
// Created by Zlata Guseva on 12.10.2022.

import SwiftyGif
import UIKit

class HomeView: UIView {
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.text = Date().string(dateFormat: .formatMMMdd)
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        tableView.register(cellWithClass: HomeCell.self)
        tableView.rowHeight = 86
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // TODO:
    private var calendarView: UIView = {
        let view = UIView()
        view.backgroundColor = .tabForeground
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
        addSubview(dateLabel)
        addSubview(tableView)
        addSubview(calendarView)
    }

    private func makeConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
        }

        calendarView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
    }
}
