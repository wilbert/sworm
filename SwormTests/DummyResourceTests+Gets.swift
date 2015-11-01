//
//  DummyResourceTests+Gets.swift
//  Sworm
//
//  Created by Wilbert on 31/10/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation
import XCTest
import Mockingjay
import Alamofire

class Client: Sworm {
    var name: String!
    var email: String!
    
    required init(response: NSHTTPURLResponse, representation: AnyObject) {
        super.init(response: response, representation: representation)
        
        self.name = representation.valueForKeyPath("name") as! String
        self.email = representation.valueForKeyPath("email") as! String
    }
}

class DummyResourceTestsGet: XCTestCase {
    var client: Client!
    
    override func setUp() {
        super.setUp()
        
        Sworm.site = "http://www.site.com"
    }
    
    func testingGetObject() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("client_10", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(uri("/clients/10"), builder: jsonData(data))
        
        let expectation = expectationWithDescription("GET clients")
        
        let params: [String: AnyObject] = ["page": "1"]
        
        Client.get(10, parameters: params, completionHandler: { (response: Alamofire.Response<Client, NSError>) in
            if response.result.isSuccess {
                self.client = response.result.value!
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(30) { (error) in
            XCTAssert(self.client.id == 10)
            XCTAssert(self.client.name == "Client name")
            XCTAssert(self.client.email == "client@site.com")
        }
    }
}