// Frequency.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift

enum Frequency: Int, CaseIterable, PersistableEnum {
    case sun = 1
    case mon = 2
    case tue = 3
    case wed = 4
    case thu = 5
    case fri = 6
    case sat = 7
    case everyday = 0

    var string: String {
        switch self {
        case .mon:
            return Texts.mon
        case .tue:
            return Texts.tue
        case .wed:
            return Texts.wed
        case .thu:
            return Texts.thu
        case .fri:
            return Texts.fri
        case .sat:
            return Texts.sat
        case .sun:
            return Texts.sun
        case .everyday:
            return Texts.everyday
        }
    }

    static var allWeek: [Frequency] {
        var array: [Frequency] = [.mon, .tue, .wed, .thu, .fri, .sat]
        array.insert(.sun, at: Calendar.current.firstWeekday == 1 ? 0 : 6)
        return array
    }
}
