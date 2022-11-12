// JTACMonthView+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import UIKit

extension JTACMonthView {
    func dequeueReusableJTAppleCell<T: JTACDayCell>(
        withClass name: T.Type,
        indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Error initializing Cell View with identifier: \(String(describing: name))")
        }
        return cell
    }

    func dequeueReusableJTAppleSupplementaryView<T: JTACMonthReusableView>(
        withClass name: T.Type,
        indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: name),
            for: indexPath
        ) as? T else {
            fatalError("Error initializing Cell View with identifier: \(String(describing: name))")
        }
        return cell
    }
}
