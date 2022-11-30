// ProfileCell.swift
// FunnyPuny. Created by Zlata Guseva.

import SwiftDate
import UIKit

// MARK: - ProfileCell

class ProfileCell: UITableViewCell {
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.image = Images.right.image
        imageView.tintColor = Colors.iconsOther.color
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
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(48)
        }

        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}

extension ProfileCell: Configurable {
    func configure(with viewModel: ProfileCellViewModel) {
        label.text = viewModel.itemName
    }
}
