// CalendarAnalyticHeaderMonthView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarAnalyticHeaderMonthView: UIView {
    var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textPrimary.color
        label.font = .bodyRegular
        label.textAlignment = .center
        return label
    }()

    var leftButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = Images.left.image
        configuration.baseBackgroundColor = Colors.backgroundGlobe.color
        configuration.baseForegroundColor = Colors.iconsOther.color
        button.configuration = configuration
        return button
    }()

    var rightButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = Images.right.image
        configuration.baseBackgroundColor = Colors.backgroundGlobe.color
        configuration.baseForegroundColor = Colors.iconsOther.color
        button.configuration = configuration
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
        addSubview(leftButton)
        addSubview(monthLabel)
        addSubview(rightButton)
    }

    private func makeConstraints() {
        leftButton.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        monthLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
        }

        rightButton.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}
