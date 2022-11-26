// CalendarHomeDateCell.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

// MARK: - CalendarHomeDateCell

class CalendarHomeDateCell: JTACDayCell {
    private var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .regular14
        label.textAlignment = .center
        return label
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .regular12
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.layer.cornerRadius = 18
        label.clipsToBounds = true
        return label
    }()

    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundGlobe
        view.layer.masksToBounds = true
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
        addSubview(containerView)
        containerView.addSubview(dayOfWeekLabel)
        containerView.addSubview(dateLabel)
    }

    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }

        dayOfWeekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(36)
        }
    }
}

// MARK: Configurable

extension CalendarHomeDateCell: Configurable {
    func configure(with viewModel: CalendarCellViewModel) {
        dateLabel.text = viewModel.date.string(dateFormat: .formatdd)
        dayOfWeekLabel.text = viewModel.date.string(dateFormat: .formatEEEEE)
        dayOfWeekLabel.textColor = viewModel.date.isToday ? .textPrimary : .textSecondary
        dateLabel.layer.borderColor = viewModel.date.isToday
            ? UIColor.backgroundAccent?.cgColor
            : UIColor.backgroundBoarder?.cgColor
        dateLabel.backgroundColor = viewModel.backgroundColor
        if viewModel.isSelected {
            containerView.layer.cornerRadius = 20
            containerView.dropShadow()
        } else {
            containerView.layer.cornerRadius = 0
            containerView.removeShadow()
        }
    }
}
