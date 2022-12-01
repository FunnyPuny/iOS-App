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
    }

    /// Строка из даты
    /// - Parameter dateFormat: Формат даты
    /// - Parameter timeZone: Часовой пояс. По умолчанию используется системный
    /// - Parameter locale: Локаль. По умолчанию используется системная
    /// - Returns: Строка из даты
    func string(dateFormat: DateFormat, timeZone: TimeZone = .current, locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
}
