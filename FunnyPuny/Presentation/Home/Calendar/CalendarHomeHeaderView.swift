// CalendarHomeHeaderView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarHomeHeaderView: UIView {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textAccent.color
        label.font = .titleLarge
        label.textAlignment = .center
        label.text = Date().string(dateFormat: .formatLLLLd)
        return label
    }()

    var addHabitButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = Images.plus.image
        configuration.baseBackgroundColor = Colors.backgroundGlobe.color
        configuration.baseForegroundColor = Colors.iconsDefault.color
        button.configuration = configuration
        button.tintAdjustmentMode = .normal
        return button
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
        addSubview(addHabitButton)
    }

    private func makeConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }

        addHabitButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(18)
        }
    }
}
