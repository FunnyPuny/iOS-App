// HomeCell.swift
// FunnyPuny. Created by Zlata Guseva.

import SwiftDate
import UIKit

// MARK: - HomeCell

class HomeCell: UITableViewCell {
    enum HomeCellState {
        case checked
        case unchecked
        case inactive

        var contentBackgroundColor: UIColor {
            switch self {
            case .checked: return Colors.backgroundIsland.color
            case .unchecked, .inactive: return Colors.backgroundGlobe.color
            }
        }

        var borderWidth: CGFloat {
            switch self {
            case .checked: return 0
            case .unchecked: return 2
            case .inactive: return 3
            }
        }

        var borderColor: CGColor {
            switch self {
            case .checked: return UIColor.clear.cgColor
            case .unchecked: return Colors.backgroundIsland.color.cgColor
            case .inactive: return Colors.backgroundBoarder.color.cgColor
            }
        }

        var textColor: UIColor {
            switch self {
            case .checked, .unchecked: return Colors.textPrimary.color
            case .inactive: return Colors.textSecondary.color
            }
        }

        var iconImage: UIImage {
            switch self {
            case .checked: return Images.checkmark.image
            case .unchecked: return Images.cicrle.image
            case .inactive: return Images.inactiveCicle.image
            }
        }
    }

    var state: HomeCellState = .unchecked

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
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
        contentView.backgroundColor = state.contentBackgroundColor
        iconImageView.image = state.iconImage
        label.textColor = state.textColor
        contentView.layer.borderColor = state.borderColor
        contentView.layer.borderWidth = state.borderWidth
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
        if viewModel.selectedDate > Date() {
            state = .inactive
        } else {
            state = viewModel.isDone ? .checked : .unchecked
        }
        setupStyle()
    }
}
