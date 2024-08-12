//
//  DateFormattingUseCase.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

protocol DateFormattingUseCase {
    func formatDate(timestamp: Int) -> String
    func formatDay(timestamp: Int) -> String
    func formatTime(timestamp: Int) -> String
}
