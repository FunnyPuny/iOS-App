// DayView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class DayView: UIView {
    var day: Frequency
    var isSelected: Bool

    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = day.string
        label.textColor = isSelected ? Colors.textButton.color : Colors.textPrimary.color
        label.font = .regular17
        label.textAlignment = .center
        return label
    }()

    required init(_ day: Frequency, isSelected: Bool = false) {
        self.day = day
        self.isSelected = isSelected
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        layer.cornerRadius = 6
        setupStyle()
        makeConstraints()
        addTap()
    }

    private func addSubviews() {
        addSubview(dayLabel)
    }

    private func makeConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }

    func setupStyle() {
        backgroundColor = isSelected ? Colors.backgroundAccent.color : Colors.backgroundIsland.color
        dayLabel.textColor = isSelected ? Colors.textButton.color : Colors.textPrimary.color
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(daySelected))
        addGestureRecognizer(tap)
    }

    @objc
    func daySelected() {
        isSelected.toggle()
        setupStyle()
    }
}
