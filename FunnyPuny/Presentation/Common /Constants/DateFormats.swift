// DateFormats.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation

extension Date {
    enum DateFormat: String {
        /// Oct, 18
        case formatMMMdd = "MMM, dd"
        /// 18
        case formatdd = "dd"
        /// T
        case formatEEEEE = "EEEEE"
        ///  October, 18
        case formatLLLLd = "LLLL, d"
        /// 18 October 2022
        case formatdMMMMyyyy = "d MMMM yyyy"
        /// 22/10/18
        case formatyyMMdd = "yy/MM/dd"
        /// October 2022
        case formatLLLLyyyy = "LLLL yyyy"
        /// 20221018
        case formatyyyyMMdd = "yyyyMMdd"
    }

    var shortForm: String {
        string(dateFormat: .formatyyyyMMdd)
    }

    var localDate: Date {
        Date() + Double(TimeZone.current.secondsFromGMT(for: Date()))
    }

    /// Строка из даты
    /// - Parameter dateFormat: Формат даты
    /// - Parameter timeZone: Часовой пояс. По умолчанию используется системный
    /// - Parameter locale: Локаль. По умолчанию используется системная
    /// - Returns: Строка из даты
    func string(dateFormat: DateFormat, timeZone: TimeZone = .current, locale: Locale = .current) -> String {
        toFormat(dateFormat.rawValue)
    }
}
