// DayView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

protocol DayViewProtocolDelegate: AnyObject {
    func dayDidSelect(index: Int?)
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
        // addTap()
//        isUserInteractionEnabled = true
//        let gesture = UIGestureRecognizer(target: self, action: #selector(onTap))
//        addGestureRecognizer(gesture)
    }

    @objc
    func onTap(tapGesture: UITapGestureRecognizer) {
        isSelected.toggle()
        setupStyle()
        delegate?.dayDidSelect(index: index)
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
