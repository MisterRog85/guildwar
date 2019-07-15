//
//  ScreenshotsUITests.swift
//  ScreenshotsUITests
//
//  Created by William Tomas on 09/07/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import XCTest

class ScreenshotsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        let general = app.tables.staticTexts["General"]
        let hero = app.tables.staticTexts["Hero"]
        let family = app.tables.staticTexts["Family Reunion"]
        snapshot("01ListeGroupe")
        general.tap()
        snapshot("02ListeCat")
        hero.tap()
        snapshot("03ListeSucces")
        family.tap()
        snapshot("04DetailSucces")
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
