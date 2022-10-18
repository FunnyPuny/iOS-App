// Day.swift
// Created by Zlata Guseva on 18.10.2022.

import RealmSwift

enum Day: String, CaseIterable, PersistableEnum {
    case mon = "MON"
    case tue = "TUE"
    case wed = "WED"
    case thu = "THU"
    case fri = "FRI"
    case sat = "SAT"
    case sun = "SUN"
}
