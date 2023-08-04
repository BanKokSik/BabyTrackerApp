//
//  Date+Extension.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 04.08.2023.
//

import Foundation

extension Date {
    func getFormatterDate(dateFormat: String = "HH:mm / dd.MM.yy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
