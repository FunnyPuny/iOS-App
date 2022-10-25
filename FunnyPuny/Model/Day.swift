// Day.swift
// Created by Zlata Guseva on 18.10.2022.

import RealmSwift

enum Day: Int, CaseIterable, PersistableEnum {
    case sun = 1
    case mon = 2
    case tue = 3
    case wed = 4
    case thu = 5
    case fri = 6
    case sat = 7

    func toString() -> String {
        switch self {
        case .mon:
            return "MON"
        case .tue:
            return "TUE"
        case .wed:
            return "WED"
        case .thu:
            return "THU"
        case .fri:
            return "FRI"
        case .sat:
            return "SAT"
        case .sun:
            return "SAN"
        }
    }
}
