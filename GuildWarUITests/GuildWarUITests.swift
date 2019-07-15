//
//  GuildWarUITests.swift
//  GuildWarUITests
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import XCTest
import Moya

class GuildWarUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /**
     Test indiquant que nous sommes bien au niveau groupe lors du lancement de l'application
     */
    func testLancement() {
     
        XCTAssertTrue(app.isDisplayingGroupe)
    }
    
    func testCat() {
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).waitForExistence(timeout: 10)
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        //sleep(5)
        XCTAssertTrue(app.isDisplayingCat)
    }
    
    func testSucces() {
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).waitForExistence(timeout: 10)
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).waitForExistence(timeout: 10)
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        //sleep(5)
        XCTAssertTrue(app.isDisplayingSucces)
    }
    
    /*func waiterResultWithExpextation() -> XCTWaiter.Result {
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: app.isDisplayingCat, handler: nil)
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 5)
        return result
    }
    
    func testWaiterCompletionXCTPredicate() {
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).waitForExistence(timeout: 5)
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        XCTAssertTrue(waiterResultWithExpextation() == .completed)
        
    }*/

}

extension XCUIApplication {
    var isDisplayingGroupe: Bool {
        return otherElements["Groupe"].exists
    }
    
    var isDisplayingCat: Bool {
        return otherElements["Categorie"].exists
    }
    
    var isDisplayingSucces: Bool {
        return otherElements["Succes"].exists
    }
}
