// Habit.swift
// Created by Zlata Guseva on 14.10.2022.

import Foundation

struct Habit {
    var name: String
    var period: [Day]
}

enum Day: String {
    case mon = "MON"
    case tue = "TUE"
    case wed = "WED"
    case thu = "THU"
    case fri = "FRI"
    case sat = "SAT"
    case sun = "SUN"
}
