// DayView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

protocol DayViewDelegate: AnyObject {
    func didSelect(_ day: Frequency)
}

class DayView: UIView {
    var day: Frequency
    var isSelected: Bool {
        didSet {
            setupStyle()
        }
    }

    weak var delegate: DayViewDelegate?

    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = day.string
        label.font = .bodyRegular
        label.textAlignment = .center
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        return button
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
    }

    @objc
    func onTap(tapGesture: UITapGestureRecognizer) {
        isSelected.toggle()
        setupStyle()
        delegate?.didSelect(day)
    }

    private func addSubviews() {
        addSubview(dayLabel)
        addSubview(button)
    }

    private func makeConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }

    func setupStyle() {
        backgroundColor = isSelected ? Colors.backgroundAccent.color : Colors.backgroundIsland.color
        dayLabel.textColor = isSelected ? Colors.textButton.color : Colors.textPrimary.color
    }
}
