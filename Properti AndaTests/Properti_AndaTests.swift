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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! RootViewController
        properties = Properties()
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
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
