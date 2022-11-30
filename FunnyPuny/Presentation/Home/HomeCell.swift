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
        imageView.backgroundColor = Colors.backgroundGlobe.color
        return imageView
    }()

    private var label: UILabel = {
        let label = UILabel()
        label.font = .regular17
        label.textColor = Colors.textPrimary.color
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
        backgroundColor = Colors.backgroundGlobe.color
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
            // TODO:
            iconImageView.image = .circle
            iconImageView.tintColor = Colors.backgroundGlobe.color
            iconImageView.layer.borderWidth = 2
            iconImageView.layer.borderColor = Colors.backgroundBoarder.color.cgColor
            contentView.backgroundColor = Colors.backgroundGlobe.color
            contentView.layer.borderColor = Colors.backgroundBoarder.color.cgColor
            contentView.layer.borderWidth = 3
            label.textColor = Colors.textSecondary.color
            isDone = false
        } else {
            label.text = viewModel.habitName
            label.textColor = Colors.textPrimary.color
            if viewModel.isDone {
                iconImageView.image = Images.checkmark2.image
                contentView.backgroundColor = Colors.backgroundIsland.color
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.borderWidth = 0
                isDone = true
            } else {
                iconImageView.image = .circle
                iconImageView.layer.borderWidth = 2
                iconImageView.layer.borderColor = Colors.backgroundIsland.color.cgColor
                iconImageView.tintColor = Colors.backgroundGlobe.color
                contentView.backgroundColor = Colors.backgroundGlobe.color
                contentView.layer.borderColor = Colors.backgroundIsland.color.cgColor
                contentView.layer.borderWidth = 2
                isDone = false
            }
        }
    }
}
