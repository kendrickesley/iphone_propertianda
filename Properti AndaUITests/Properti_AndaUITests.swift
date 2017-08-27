//
//  Properti_AndaUITests.swift
//  Properti AndaUITests
//
//  Created by Kendrick on 19/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import XCTest

class Properti_AndaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testIntroFirstScreen(){
        let app = XCUIApplication()
        // Test that the initial label text is what you expect
        // Test that there are 2 images dispayed on the view
        XCTAssertEqual(app.images.count, 2)
        // Test that there is only 1 button on the view
        XCTAssertEqual(app.buttons.count, 0)
        //Test that there are 3 static texts on the view
        XCTAssertEqual(app.staticTexts.count, 3)
        
        //The element with identifier welcome_title should have Welcome as the value
        var string = app.staticTexts.element(matching: .any, identifier: "welcome_title").label
        XCTAssertEqual(string, "Welcome")
        
        //The element with identifier welcome_second_p should have To The Future as the value
        string = app.staticTexts.element(matching: .any, identifier: "welcome_second_p").label
        XCTAssertEqual(string, "To The Future")
        
        //The element with identifier welcome_third_p should have of Investment  as the value
        string = app.staticTexts.element(matching: .any, identifier: "welcome_third_p").label
        XCTAssertEqual(string, "of Investment")
    }
    
    func testIntroSecondScreen() {
        let app = XCUIApplication()
        app.staticTexts.element(matching: .any, identifier: "welcome_title").swipeLeft()
        XCTAssertEqual(app.images.count, 4)
        XCTAssertEqual(app.staticTexts.count, 3)
        XCTAssertEqual(app.buttons.count, 0)
        
        var string = app.staticTexts.element(matching: .any, identifier: "intro_first_circle").label
        XCTAssertEqual(string, "Join Us")
        string = app.staticTexts.element(matching: .any, identifier: "intro_second_circle").label
        XCTAssertEqual(string, "Buy Properties")
        string = app.staticTexts.element(matching: .any, identifier: "intro_third_circle").label
        XCTAssertEqual(string, "Collect Profits")
    }
    
    func testIntroThirdScreen(){
        let app = XCUIApplication()
        app.staticTexts.element(matching: .any, identifier: "welcome_title").swipeLeft()
        app.staticTexts.element(matching: .any, identifier: "intro_first_circle").swipeLeft()
        
        XCTAssertEqual(app.images.count, 1)
        XCTAssertEqual(app.staticTexts.count, 1)
        XCTAssertEqual(app.buttons.count, 1)
        
        var string = app.staticTexts.element(matching: .any, identifier: "intro_start_journey").label
        XCTAssertEqual(string, "Start Your Journey")
        
        string = app.buttons.element(matching: .any, identifier: "intro_button_start").label
        XCTAssertEqual(string, "Log In")
    }
    
    func testLoginScreen(){
        let app = XCUIApplication()
        app.staticTexts.element(matching: .any, identifier: "welcome_title").swipeLeft()
        app.staticTexts.element(matching: .any, identifier: "intro_first_circle").swipeLeft()
        app.buttons.element(matching: .any, identifier: "intro_button_start").tap()
        
        XCTAssertEqual(app.textFields.count, 1)
        XCTAssertEqual(app.secureTextFields.count, 1)
        XCTAssertEqual(app.staticTexts.count, 2)
        XCTAssertEqual(app.buttons.count, 2)
        XCTAssertEqual(app.images.count, 1)
        
        var string = app.staticTexts.element(matching: .any, identifier: "login_title").label
        XCTAssertEqual(string, "Properti Anda")
        string = app.staticTexts.element(matching: .any, identifier: "login_or_label").label
        XCTAssertEqual(string, "Or")
        string = app.textFields.element(matching: .any, identifier: "login_email_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.secureTextFields.element(matching: .any, identifier: "login_password_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.buttons.element(matching: .any, identifier: "login_login_button").label
        XCTAssertEqual(string, "Login")
        string = app.buttons.element(matching: .any, identifier: "login_sign_up_button").label
        XCTAssertEqual(string, "Sign Up")
    }
    
    func testSignUpScreen(){
        let app = XCUIApplication()
        app.staticTexts.element(matching: .any, identifier: "welcome_title").swipeLeft()
        app.staticTexts.element(matching: .any, identifier: "intro_first_circle").swipeLeft()
        app.buttons.element(matching: .any, identifier: "intro_button_start").tap()
        app.buttons.element(matching: .any, identifier: "login_sign_up_button").tap()
        
        XCTAssertEqual(app.textFields.count, 4)
        XCTAssertEqual(app.secureTextFields.count, 2)
        XCTAssertEqual(app.staticTexts.count, 2)
        XCTAssertEqual(app.buttons.count, 2)
        XCTAssertEqual(app.images.count, 1)
        
        var string = app.staticTexts.element(matching: .any, identifier: "signup_title").label
        XCTAssertEqual(string, "Sign Up")
        string = app.staticTexts.element(matching: .any, identifier: "signup_or_label").label
        XCTAssertEqual(string, "Or")
        string = app.textFields.element(matching: .any, identifier: "signup_firstname_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.textFields.element(matching: .any, identifier: "signup_lastname_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.textFields.element(matching: .any, identifier: "signup_email_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.secureTextFields.element(matching: .any, identifier: "signup_password_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.secureTextFields.element(matching: .any, identifier: "signup_confirm_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.textFields.element(matching: .any, identifier: "signup_id_field").placeholderValue!
        XCTAssertEqual(string, "")
        string = app.buttons.element(matching: .any, identifier: "signup_login_button").label
        XCTAssertEqual(string, "Login")
        string = app.buttons.element(matching: .any, identifier: "signup_signup_button").label
        XCTAssertEqual(string, "Sign Up")
        XCTAssertTrue(app.buttons.element(matching: .any, identifier: "signup_login_button").isHittable)
        XCTAssertTrue(app.buttons.element(matching: .any, identifier: "signup_signup_button").isHittable)
    }
    
    func testDrawerScreen(){
        let app = XCUIApplication()
        app.staticTexts.element(matching: .any, identifier: "welcome_title").swipeLeft()
        app.staticTexts.element(matching: .any, identifier: "intro_first_circle").swipeLeft()
        app.buttons.element(matching: .any, identifier: "intro_button_start").tap()
        app.buttons.element(matching: .any, identifier: "login_login_button").tap()
        XCUIDevice.shared().orientation = UIDeviceOrientation.portrait
        let coor1:XCUICoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 30))
        let coor2:XCUICoordinate = coor1.withOffset(CGVector(dx: 500, dy: 30))
        coor1.press(forDuration: 0.3, thenDragTo: coor2)
        XCTAssertTrue(app.buttons["Log Out"].exists)
        XCUIDevice.shared().orientation = UIDeviceOrientation.landscapeLeft
        XCTAssertTrue(app.buttons["Log Out"].exists)
        XCTAssertEqual(app.textFields.count, 1)
        XCTAssertTrue(app.tables.staticTexts["Home"].exists)
        XCTAssertTrue(app.tables.staticTexts["Dashboard"].exists)
        XCTAssertTrue(app.tables.staticTexts["Portfolio"].exists)
        XCTAssertTrue(app.tables.staticTexts["Preferences"].exists)
    }
    
    func testPropertyListScreen(){
        let app = XCUIApplication()
        app.staticTexts.element(matching: .any, identifier: "welcome_title").swipeLeft()
        app.staticTexts.element(matching: .any, identifier: "intro_first_circle").swipeLeft()
        app.buttons.element(matching: .any, identifier: "intro_button_start").tap()
        app.buttons.element(matching: .any, identifier: "login_login_button").tap()
        
        
        XCTAssertEqual(app.navigationBars.buttons.count, 1)
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertTrue(app.navigationBars.staticTexts["Properties"].exists)
        XCUIDevice.shared().orientation = UIDeviceOrientation.portrait
        
        XCTAssertFalse(app.staticTexts["Select a property"].exists)
        
        XCUIDevice.shared().orientation = UIDeviceOrientation.landscapeLeft
        XCTAssertEqual(app.images.count, 2)
        
        XCTAssertTrue(app.staticTexts["Select a property"].exists)
    }
    
    func testPropertyDetailScreen(){
        XCUIDevice.shared().orientation = UIDeviceOrientation.portrait
        let app = XCUIApplication()
        app.staticTexts.element(matching: .any, identifier: "welcome_title").swipeLeft()
        app.staticTexts.element(matching: .any, identifier: "intro_first_circle").swipeLeft()
        app.buttons.element(matching: .any, identifier: "intro_button_start").tap()
        app.buttons.element(matching: .any, identifier: "login_login_button").tap()
        
        app.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["Invest"].exists)
        XCTAssertEqual(app.navigationBars.buttons.count, 1)
        XCTAssertFalse(app.navigationBars.staticTexts["Properties"].exists)
        XCTAssertTrue(app.navigationBars.staticTexts["Property Detail"].exists)
        XCTAssertEqual(app.staticTexts.count, 6)
        
        XCUIDevice.shared().orientation = UIDeviceOrientation.landscapeLeft
        XCTAssertEqual(app.navigationBars.buttons.count, 1)
        XCTAssertTrue(app.navigationBars.staticTexts["Properties"].exists)
        XCTAssertFalse(app.navigationBars.staticTexts["Property Detail"].exists)
    }
    
}
