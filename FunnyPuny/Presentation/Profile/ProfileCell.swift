// HomeCell.swift
// FunnyPuny. Created by Zlata Guseva.

import SwiftDate
import UIKit

// MARK: - ProfileCell

class ProfileCell: UITableViewCell {
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.image = .right
        imageView.backgroundColor = .iconsOther
        return imageView
    }()

    private var label: UILabel = {
        let label = UILabel()
        label.font = .regular17
        label.textColor = .textPrimary
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
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}

