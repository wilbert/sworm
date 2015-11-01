//
//  DummyResource.swift
//  Sworm
//
//  Created by Wilbert on 30/10/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation
import XCTest

class DummyResource: Sworm {
    override class func resource() -> String {
        return "dummies"
    }
}

class DummyResourceTests: XCTestCase {
    override func setUp() {
        Sworm.site = "http://www.site.com"
    }
    
    func testDummyMountURL() {
        let url = DummyResource.mountResourceURL()
        XCTAssert(url == "http://www.site.com/dummies")
    }

    func testDummyMountURLWithId() {
        let url = DummyResource.mountResourceURL(10)
        XCTAssert(url == "http://www.site.com/dummies/10")
    }
    
    func testDummyMountURLWithPath() {
        let url = DummyResource.mountResourceURL("actives")
        XCTAssert(url == "http://www.site.com/dummies/actives")
    }
    
    func testDummyMountURLWithIdAndPath() {
        let url = DummyResource.mountResourceURL(10, path: "actives")
        XCTAssert(url == "http://www.site.com/dummies/10/actives")
    }

    func testNewObject() {
        let dummy = DummyResource()
        
        XCTAssert(dummy.isNewObject() == true)
    }
    
    func testNotNewObject() {
        let dummy = DummyResource()
        dummy.id = 10
        XCTAssert(dummy.isNewObject() == false)
    }

}