// CalendarAnalyticView.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarAnalyticView: UIView {
    var monthView: JTACMonthView = {
        let view = JTACMonthView()
        view.register(CalendarAnalyticDateCell.self, forCellWithReuseIdentifier: "CalendarAnalyticDateCell")
        view.register(
            CalendarAnalyticHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CalendarAnalyticHeaderView"
        )
        view.backgroundColor = Colors.backgroundGlobe.color
        view.scrollDirection = .horizontal
        view.scrollingMode = .none
        view.showsHorizontalScrollIndicator = false
        view.cellSize = (UIScreen.main.bounds.width - 64) / 7
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
        layer.borderWidth = 1
        layer.borderColor = Colors.backgroundIsland.color.cgColor
        layer.cornerRadius = 16
    }

    private func addSubviews() {
        addSubview(monthView)
    }

    private func makeConstraints() {
        monthView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(16)
        }
    }
}
