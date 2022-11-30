// ProfileView.swift
// FunnyPuny. Created by Zlata Guseva.

import SwiftyGif
import UIKit

class ProfileView: UIView {
    private var gifImageView: UIImageView = .profileGIF
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundGlobe
        tableView.register(cellWithClass: ProfileCell.self)
        tableView.rowHeight = 64
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 16
        tableView.layer.borderColor = UIColor.backgroundIsland.cgColor
        tableView.layer.borderWidth = 2
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
        backgroundColor = .backgroundGlobe
    }

    private func addSubviews() {
        addSubview(gifImageView)
        addSubview(tableView)
    }

    private func makeConstraints() {
        gifImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(gifImageView.snp.bottom).offset(44)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(256)
        }
    }
}
