//
//  DateFormattingUseCaseImplTests.swift
//  weatherTests
//
//  Created by lamha on 16/08/2024.
//

import XCTest
@testable import weather

final class DateFormattingUseCaseImplTests: XCTestCase {
    var dateFormattingUseCase: DateFormattingUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        dateFormattingUseCase = DateFormattingUseCaseImpl()
    }
    
    override func tearDown() {
        dateFormattingUseCase = nil
        super.tearDown()
    }
    
    func testFormatDate() {
        // Given
        let timestamp = 1622505600
        let expectedDate = "Tuesday, 1 June 2021"
        
        // When
        let formattedDate = dateFormattingUseCase.formatDate(timestamp: timestamp)
        
        // Then
        XCTAssertEqual(formattedDate, expectedDate, "Formatted date should match the expected date")
    }
    
    func testFormatDay() {
        // Given
        let timestamp = 1622505600
        let expectedDay = "Tue"
        
        // When
        let formattedDay = dateFormattingUseCase.formatDay(timestamp: timestamp)
        
        // Then
        XCTAssertEqual(formattedDay, expectedDay, "Formatted day should match the expected day")
    }
    
    func testFormatTime() {
        // Given
        let timestamp = 1622505600
        let expectedTime = "07 AM"
        
        // When
        let formattedTime = dateFormattingUseCase.formatTime(timestamp: timestamp)
        
        // Then
        XCTAssertEqual(formattedTime, expectedTime, "Formatted time should match the expected time")
    }
}
