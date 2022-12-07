// FrequencyView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class FrequencyView: UIView {
    var viewState: ViewState

    private var label: UILabel = {
        let label = UILabel()
        label.text = Texts.frequency
        label.textColor = Colors.textPrimary.color
        label.font = .regular20
        return label
    }()

    var everydayView = DayView(.everyday, isSelected: true)

    let views: [DayView] = {
        var views = Frequency.allCases.map { DayView($0) }
        views.removeLast()
        return views
    }()

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

    required init(viewState: ViewState = .everyday) {
        self.viewState = viewState
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
    }

    private func addSubviews() {
        addSubview(label)
        addSubview(everydayView)
        addSubview(scrollView)
        stackView.addArrangedSubviews(views)
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
