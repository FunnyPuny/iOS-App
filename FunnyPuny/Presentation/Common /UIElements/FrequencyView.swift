// FrequencyView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

protocol FrequencyViewDelegate: AnyObject {
    func didSelect(_ frequencies: [Frequency])
}

class FrequencyView: UIView {
    var selectedFrequencies: [Frequency] = [.everyday]
    weak var delegate: FrequencyViewDelegate?

    private var label: UILabel = {
        let label = UILabel()
        label.text = Texts.frequency
        label.textColor = Colors.textPrimary.color
        label.font = .bodyMedium
        return label
    }()

    private var dayViews: [DayView] = []
    private var everydayView = DayView(.everyday, isSelected: true)
    private var weekdayViews = Frequency.allWeek.map { DayView($0) }

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }()

    private var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return scrollView
    }()

    required init() {
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
        setup()
    }

    private func setup() {
        weekdayViews.forEach { $0.delegate = self }
        everydayView.delegate = self

        dayViews = weekdayViews.map { $0 }
        dayViews.append(everydayView)
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(everydayView)
        addSubview(scrollView)
        stackView.addArrangedSubviews(weekdayViews)
        scrollView.addSubview(stackView)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }

        everydayView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(everydayView.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.snp.edges)
            make.height.equalTo(scrollView.snp.height)
        }
    }
}

extension FrequencyView: DayViewDelegate {
    func didSelect(_ day: Frequency) {
        selectedFrequencies = []

        if day == .everyday {
            weekdayViews.forEach { $0.isSelected = false }
        } else {
            everydayView.isSelected = false
        }

        for dayView in dayViews where dayView.isSelected {
            selectedFrequencies.append(dayView.day)
        }
        delegate?.didSelect(selectedFrequencies)
    }
}
