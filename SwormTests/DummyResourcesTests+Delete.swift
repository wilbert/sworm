//
//  DummyResourcesTests+Delete.swift
//  Sworm
//
//  Created by Wilbert on 05/11/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
import Mockingjay

class DummyResourceTestsDelete: XCTestCase {
    override func setUp() {
        Sworm.site = "http://www.site.com"
    }
    
    func testingUpdate() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("client_10", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(uri("/clients/10"), builder: jsonData(data))
        
        let expectation = expectationWithDescription("DELETE clients")
        var client: Client! = Client()
        
        client.id = 10
        
        Client.delete(client.id, parameters: Dictionary<String, AnyObject>()) { (response: Alamofire.Response<Client, NSError>) -> Void in
            if response.result.isSuccess {
                client = response.result.value!
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30) { (error) in
            XCTAssert(client.id == 10)
            XCTAssert(client.name == "Client name")
            XCTAssert(client.email == "client@site.com")
        }
    }
}
