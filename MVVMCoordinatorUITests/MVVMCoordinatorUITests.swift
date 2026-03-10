//
//  MVVMCoordinatorUITests.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import XCTest

final class MVVMCoordinatorUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--ui-testing")
        app.launchEnvironment = ["USE_MOCK_API": "true"]
    
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        app.activate()
        app.buttons["Register New"].firstMatch.tap()
        app.buttons["Regitser"].firstMatch.tap()
        app.buttons["Login"].firstMatch.tap()
        app.images["gear"].firstMatch.tap()
        
        let element = app.switches["1"].firstMatch
        element.tap()
        app.staticTexts["Logout"].firstMatch.tap()
        app.launchEnvironment["isLoggedIn"] = "false"
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
