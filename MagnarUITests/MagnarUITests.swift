//
//  MagnarUITests.swift
//  MagnarUITests
//
//  Created by Michael Amiro on 03/11/2022.
//

import XCTest

final class MagnarUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testHouseOfAppletonNavigation() throws {
        app = XCUIApplication()
        app.launch()
        let tablesQuery = XCUIApplication().tables
        XCTAssertTrue(tablesQuery.element.exists)
        tablesQuery.staticTexts["Houses"].tap()
        tablesQuery.staticTexts["House Appleton of Appleton"].swipeUp()
        let theReachLabel = tablesQuery.staticTexts["The Reach"]
        XCTAssertTrue(theReachLabel.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
