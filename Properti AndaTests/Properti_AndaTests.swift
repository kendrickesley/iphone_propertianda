//
//  Properti_AndaTests.swift
//  Properti AndaTests
//
//  Created by Kendrick on 19/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import XCTest
@testable import Properti_Anda

class Properti_AndaTests: XCTestCase {
    
    var vc: RootViewController!
    var properties: Properties!
    var investments: Investments!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! RootViewController
        properties = Properties()
        investments = Investments()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testProperties() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(properties.getAllProperties().count == 0)
        properties.requestProperties {
            XCTAssert(self.properties.getAllProperties().count != 0)
            XCTAssert(self.properties.getProperty(byIndex: 0).detail.characters.count == 0)
            self.properties.getProperty(byIndex: 0).requestDetail(){
                XCTAssert(self.properties.getProperty(byIndex: 0).getDetail().characters.count != 0)
            }
        }
    }
    
    func testRegisterAccount(){
        let email = randomString(length: 15) + "@" + randomString(length: 5) + "." + randomString(length: 3)
        let password = randomString(length: 15)
        PARequest.register(email: email, password: password, firstName: "Kendrick", lastName: "Kesley", id_number: "123123"){success in
            XCTAssertFalse(success)
            PARequest.login(email: email, password:password){success in
                XCTAssertTrue(success)
            }
        }
    }
    
    func testRegisterDuplicateAccount(){
        PARequest.register(email: "s3642811@student.rmit.edu.au", password: "kendrick", firstName: "Kendrick", lastName: "Kesley", id_number: "123123"){success in
            XCTAssertFalse(success)
        }
    }
    
    func testLogin(){
        let email = randomString(length: 15) + "@" + randomString(length: 5) + "." + randomString(length: 3)
        let password = randomString(length: 15)
        PARequest.login(email: email, password: password){success in
            XCTAssertFalse(success)
        }
        PARequest.login(email: "s3642811@student.rmit.edu.au", password:"kendrick"){success in
            XCTAssertTrue(success)
        }
    }
    
    func testInvestments(){
        XCTAssert(investments.getAllInvestments().count == 0)
        PARequest.login(email: "s3642811@student.rmit.edu.au", password:"kendrick"){success in
            XCTAssert(success)
            if success {
                self.investments.requestInvestments() {
                    let investments:[Investment] = self.investments.getAllInvestments()
                    XCTAssert(investments.count != 0)
                }
            }
        }
        
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
