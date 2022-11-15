// HomeCell.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

// MARK: - HomeCell

class HomeCell: UITableViewCell {
    var isDone = false

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.image = .circle
        imageView.backgroundColor = .background
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
        backgroundColor = .background
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
        label.text = viewModel.habitName
        if viewModel.isDone {
            iconImageView.image = .checkmark
            iconImageView.tintColor = .vividPink
            contentView.backgroundColor = .background
            contentView.layer.borderColor = UIColor.pinkLight?.cgColor
            contentView.layer.borderWidth = 2
            isDone = true
        } else {
            iconImageView.image = .circle
            iconImageView.tintColor = .background
            contentView.backgroundColor = .pinkLight
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.borderWidth = 0
            isDone = false
        }
    }
}
