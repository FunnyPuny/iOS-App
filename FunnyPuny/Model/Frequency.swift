// Frequency.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift

enum Frequency: Int, CaseIterable, PersistableEnum {
    case sun = 1
    case mon = 2
    case tue = 3
    case wed = 4
    case thu = 5
    case fri = 6
    case sat = 7

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
        }
    }
}
