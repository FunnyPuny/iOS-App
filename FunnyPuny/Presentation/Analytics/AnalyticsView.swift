// AnalyticsView.swift
// FunnyPuny. Created by Zlata Guseva.

import SnapKit
import UIKit

class AnalyticsView: UIView {
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .vividPink
        label.font = .bold20
        label.text = Texts.allHabits
        return label
    }()

    var pointerBotton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = .down
        configuration.image?.withTintColor(.vividPink ?? .clear)
        // configuration.preferredSymbolConfigurationForImage = .init(weight: .bold)
        configuration.baseBackgroundColor = .background
        configuration.baseForegroundColor = .vividPink
        button.configuration = configuration
        return button
    }()

    var achivmentView = AchivmentView()

    var calendarView: CalendarAnalyticView = {
        let view = CalendarAnalyticView()
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
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .background
    }

    private func addSubviews() {
        addSubview(categoryLabel)
        addSubview(pointerBotton)
        addSubview(achivmentView)
        addSubview(calendarView)
    }

    private func makeConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }

        pointerBotton.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(4)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.size.equalTo(16)
        }

        achivmentView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(76)
        }

        calendarView.snp.makeConstraints { make in
            make.top.equalTo(achivmentView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(364)
        }
    }
}
