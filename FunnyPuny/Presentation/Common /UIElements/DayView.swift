// DayView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

protocol DayViewProtocolDelegate: AnyObject {
    func didSelect(index: Int?)
}

class DayView: UIView {
    var day: Frequency
    var isSelected: Bool
    weak var delegate: DayViewProtocolDelegate?
    var index: Int?

    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = day.string
        label.font = .regular17
        label.textAlignment = .center
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()

    required init(_ day: Frequency, isSelected: Bool = false) {
        self.day = day
        self.isSelected = isSelected
        index = day.rawValue
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        let gesture = UIGestureRecognizer(target: self, action: #selector(onTap))
        addGestureRecognizer(gesture)
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
        // addTap()
    }

    @objc
    func onTap() {
        isSelected.toggle()
        setupStyle()
        delegate?.didSelect(index: index)
    }

    private func addSubviews() {
        addSubview(dayLabel)
        addSubview(button)
    }

    private func makeConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
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
