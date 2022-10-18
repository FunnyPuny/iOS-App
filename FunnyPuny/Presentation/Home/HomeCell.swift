// HomeCell.swift
// Created by Zlata Guseva on 18.10.2022.

import UIKit

class HomeCell: UITableViewCell {
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.image = .checkmark
        imageView.tintColor = .tabForeground
        return imageView
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
        setupStyle()
    }

    private func setupStyle() {
        backgroundColor = .background
        selectionStyle = .none
        contentView.backgroundColor = .primaryText?.withAlphaComponent(0.5)
        contentView.layer.cornerRadius = 16
    }

    private func addSubviews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
    }

    private func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.leading.equalToSuperview().inset(16)
        }

        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(48)
        }

        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }
}
