//
//  TimeFormatterTests.swift
//  Food DeliveryTests
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import XCTest

final class TimeFormatterTests: XCTestCase {

    func testFormattedTime() {
            // Test for zero minutes
            XCTAssertEqual(TimeFormatter.formattedTime(minutesTotal: 0), "")
            
            // Test for one minute
            XCTAssertEqual(TimeFormatter.formattedTime(minutesTotal: 1), "1 min")
            
            // Test for multiple minutes
            XCTAssertEqual(TimeFormatter.formattedTime(minutesTotal: 5), "5 mins")
            
            // Test for one hour
            XCTAssertEqual(TimeFormatter.formattedTime(minutesTotal: 60), "1 hour")
            
            // Test for multiple hours
            XCTAssertEqual(TimeFormatter.formattedTime(minutesTotal: 120), "2 hours")
            
            // Test for a combination of hours and minutes
            XCTAssertEqual(TimeFormatter.formattedTime(minutesTotal: 90), "1 hour 30 mins")
        }

}
