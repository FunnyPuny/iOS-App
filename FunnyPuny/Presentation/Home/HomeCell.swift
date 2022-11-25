// HomeCell.swift
// FunnyPuny. Created by Zlata Guseva.

import SwiftDate
import UIKit

// MARK: - HomeCell

class HomeCell: UITableViewCell {
    var isDone = false

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.image = .circle
        imageView.backgroundColor = .backgroundGlobe
        return imageView
    }()

    private var label: UILabel = {
        let label = UILabel()
        label.font = .regular17
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
        backgroundColor = .backgroundGlobe
        selectionStyle = .none
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

// MARK: Configurable

extension HomeCell: Configurable {
    func configure(with viewModel: HomeCellViewModel) {
        if viewModel.selectedDate > Date() {
            iconImageView.image = .circle
            iconImageView.tintColor = .backgroundGlobe
            contentView.backgroundColor = .backgroundBoarder
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.borderWidth = 0
            label.textColor = .textPrimary
            isDone = false
        } else {
            label.text = viewModel.habitName
            if viewModel.isDone {
                iconImageView.image = .checkmark
                iconImageView.tintColor = .iconsActive
                contentView.backgroundColor = .backgroundGlobe
                contentView.layer.borderColor = UIColor.backgroundIsland.cgColor
                contentView.layer.borderWidth = 2
                isDone = true
            } else {
                iconImageView.image = .circle
                iconImageView.tintColor = .backgroundGlobe
                contentView.backgroundColor = .backgroundIsland
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.borderWidth = 0
                isDone = false
            }
        }
    }
}
