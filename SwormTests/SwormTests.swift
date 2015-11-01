//
//  SwormTests.swift
//  SwormTests
//
//  Created by Wilbert Ribeiro on 30/10/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import XCTest
@testable import Sworm

class SwormTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Sworm.site = "http://www.site.com"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMountResourceURLBase() {
        let url = Sworm.mountResourceURL()
        XCTAssert(url == "http://www.site.com/sworms")
    }

}
