//
//  WeatherDataUseCaseImplTests.swift
//  weatherTests
//
//  Created by lamha on 16/08/2024.
//

import XCTest
@testable import weather

final class WeatherDataUseCaseImplTests: XCTestCase {
    var weatherDataUseCase: WeatherDataUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        weatherDataUseCase = WeatherDataUseCaseImpl()
    }
    
    override func tearDown() {
        weatherDataUseCase = nil
        super.tearDown()
    }
    
    func testGetTemperature() {
        // Given
        let temp = 23.456
        let expectedTemperature = "23.5"
        
        // When
        let temperature = weatherDataUseCase.getTemperature(temp: temp)
        
        // Then
        XCTAssertEqual(temperature, expectedTemperature, "Temperature should match the expected format")
    }
    
    func testGetWindSpeed() {
        // Given
        let windSpeed = 5.678
        let expectedWindSpeed = "5.7"
        
        // When
        let windSpeedString = weatherDataUseCase.getWindSpeed(windSpeed: windSpeed)
        
        // Then
        XCTAssertEqual(windSpeedString, expectedWindSpeed, "Wind speed should match the expected format")
    }
    
    func testGetHumidity() {
        // Given
        let humidity = 85
        let expectedHumidity = "85%"
        
        // When
        let humidityString = weatherDataUseCase.getHumidity(humidity: humidity)
        
        // Then
        XCTAssertEqual(humidityString, expectedHumidity, "Humidity should match the expected format")
    }
    
    func testGetRainChances() {
        // Given
        let dewPoint = 12.345
        let expectedRainChances = "12.3%"
        
        // When
        let rainChances = weatherDataUseCase.getRainChances(dewPoint: dewPoint)
        
        // Then
        XCTAssertEqual(rainChances, expectedRainChances, "Rain chances should match the expected format")
    }
    
    func testGetWeatherIconFor() {
        // Given
        let icon = "02d"
        let expectedIcon = "cloud.sun.fill"
        
        // When
        let weatherIcon = weatherDataUseCase.getWeatherIconFor(icon: icon)
        
        // Then
        XCTAssertEqual(weatherIcon, expectedIcon, "Weather icon should match the expected value")
    }
}
