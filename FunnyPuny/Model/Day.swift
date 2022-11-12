// Day.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift

enum Day: Int, CaseIterable, PersistableEnum {
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
            return "Mon"
        case .tue:
            return "Tue"
        case .wed:
            return "Wed"
        case .thu:
            return "Thu"
        case .fri:
            return "Fri"
        case .sat:
            return "Sat"
        case .sun:
            return "San"
        case .everyday:
            return "Everyday"
        }
    }
}
