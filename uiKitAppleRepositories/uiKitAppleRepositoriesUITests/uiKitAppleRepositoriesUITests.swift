//
//  uiKitAppleRepositoriesUITests.swift
//  uiKitAppleRepositoriesUITests
//
//  Created by Jun Zhang on 2022/1/20.
//

import XCTest

class uiKitAppleRepositoriesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()


        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testAppleRepositoriesTextExists() {
        XCTAssertTrue(app.staticTexts["Apple Repositories"].exists)
    }

    func testTableViewExists() {
        XCTAssertTrue(app.tables["appleTableView"].exists)
    }

    func testAppleActivityIndicatorExists() {
        XCTAssertTrue(app.activityIndicators["appleActivityIndicator"].exists)
    }

    func testUI() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["2015-11-03"]/*[[".cells.staticTexts[\"2015-11-03\"]",".staticTexts[\"2015-11-03\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["2017-12-14"]/*[[".cells.staticTexts[\"2017-12-14\"]",".staticTexts[\"2017-12-14\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["FoundationDB - the open source, distributed, transactional key-value store"]/*[[".cells.staticTexts[\"FoundationDB - the open source, distributed, transactional key-value store\"]",".staticTexts[\"FoundationDB - the open source, distributed, transactional key-value store\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Turi Create simplifies the development of custom machine learning models."]/*[[".cells.staticTexts[\"Turi Create simplifies the development of custom machine learning models.\"]",".staticTexts[\"Turi Create simplifies the development of custom machine learning models.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
