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
        
        let element = app.buttons["Register Now!"].firstMatch
        element.tap()
        app.buttons["Cancel"].firstMatch.tap()
        element.tap()
        app.textFields["Name"].firstMatch.tap()
        app.textFields["Name"].firstMatch.typeText("Test User")
        
        let element2 = app.textFields["Username"].firstMatch
        element2.tap()
        app.textFields["Username"].firstMatch.typeText("testuser")
        
        let element3 = app.secureTextFields["Password"].firstMatch
        element3.tap()
        app.secureTextFields["Password"].firstMatch.typeText("test@123")
        app.buttons["Register"].firstMatch.tap()
        
        if app.scrollViews.otherElements.buttons["Not Now"].waitForExistence(timeout: 2) {
            app.scrollViews.otherElements.buttons["Not Now"].tap()
        }
    
        app.buttons["Forgot password?"].firstMatch.tap()
        
        let element5 = app.textFields["Username"].firstMatch
        if app.textFields["Username"].waitForExistence(timeout: 2) {
            element5.tap()
        }
        app.textFields["Username"].firstMatch.typeText("testuser")
        app.buttons["Submit"].firstMatch.tap()
        element5.tap()
        app.textFields["Username"].firstMatch.typeText("testuser")
        element3.tap()
        app.secureTextFields["Password"].firstMatch.typeText("test@123")
        app.buttons["Login"].firstMatch.tap()
        
        if app.scrollViews.otherElements.buttons["Not Now"].waitForExistence(timeout: 2) {
            app.scrollViews.otherElements.buttons["Not Now"].tap()
        }
        
        if app.images["gear"].waitForExistence(timeout: 2) {
            app.images["gear"].firstMatch.tap()
            app.buttons["Logout"].firstMatch.tap()
        }
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
