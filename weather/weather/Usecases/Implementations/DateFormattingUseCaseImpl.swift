//
//  DateFormattingUseCaseImpl.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

class DateFormattingUseCaseImpl: DateFormattingUseCase {
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()

    func formatDate(timestamp: Int) -> String {
        dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }

    func formatDay(timestamp: Int) -> String {
        dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }

    func formatTime(timestamp: Int) -> String {
        timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
}
