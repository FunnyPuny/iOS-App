// CalendarAnalyticDateCell.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

// MARK: - CalendarAnalyticDateCell

class CalendarAnalyticDateCell: JTACDayCell {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.textAlignment = .center
        label.layer.cornerRadius = 18
        label.layer.cornerCurve = .continuous
        label.clipsToBounds = true
        return label
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
    }

    private func makeConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.size.equalTo(36)
        }
    }
}

// MARK: Configurable

extension CalendarAnalyticDateCell: Configurable {
    func configure(with viewModel: CalendarCellViewModel) {
        dateLabel.text = viewModel.date.string(dateFormat: .formatdd)
        dateLabel.textColor = viewModel.isDateBelongsToCurrentMonth
            ? Colors.textPrimary.color
            : Colors.textTertiary.color
        dateLabel.backgroundColor = viewModel.isDateBelongsToCurrentMonth
            ? viewModel.backgroundColor
            : Colors.backgroundGlobe.color
        dateLabel.layer.borderColor = viewModel.isDateBelongsToCurrentMonth
            ? viewModel.date.isToday
            ? Colors.backgroundAccent.color.cgColor
            : Colors.backgroundBoarder.color.cgColor
            : UIColor.clear.cgColor
        dateLabel.layer.borderWidth = viewModel.isDateBelongsToCurrentMonth ? 2 : 0
    }
}
