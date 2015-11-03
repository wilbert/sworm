//
//  DummyResourcesTests+Creation.swift
//  Sworm
//
//  Created by Wilbert on 01/11/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
import Mockingjay

class Dummy: Sworm {
    var name: String!
    var email: String!
    
    func thisIsAMethod() {
        // nothing here
    }
}

class DummyResourcesTestsCreation: XCTestCase {
    override func setUp() {
        Sworm.site = "http://www.site.com"
    }
    
    func testingCreation() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("client_10", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(uri("/clients"), builder: jsonData(data))
        
        let expectation = expectationWithDescription("POST clients")
        let params: [String: AnyObject] = ["client[id]": "10", "client[name]": "Client name", "client[email]": "client@site.com"]
        var client: Client!
        
        Client.create(params) { (response: Alamofire.Response<Client, NSError>) -> Void in
            if response.result.isSuccess {
                client = response.result.value!
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30) { (error) in
            XCTAssert(client.id == 10)
        }
    }
}