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

final class Client: Sworm, ResponseCollectionSerializable {
    var name: String!
    var email: String!
    
    required init(response: NSHTTPURLResponse, representation: AnyObject) {
        super.init(response: response, representation: representation)
        
        self.name = representation.valueForKeyPath("name") as! String
        self.email = representation.valueForKeyPath("email") as! String
    }
    
    class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Client] {
        let array = representation.valueForKeyPath("clients") as! [AnyObject]
        return array.map({ Client(response: response, representation: $0) })
    }
}

class Address: Sworm {
    var street: String!
    var number: Int!
    
    required init(response: NSHTTPURLResponse, representation: AnyObject) {
        super.init(response: response, representation: representation)
        
        self.street = representation.valueForKeyPath("street") as! String
        self.number = representation.valueForKeyPath("number") as! Int
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
    
    func testingGetObjectWithIdOnly() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("client_10", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(uri("/clients/10"), builder: jsonData(data))
        
        let expectation = expectationWithDescription("GET clients")
        
        Client.get(10, completionHandler: { (response: Alamofire.Response<Client, NSError>) in
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
    
    func testingGetObjectWithIdAndPathAndParameters() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("address", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(uri("/clients/10/address"), builder: jsonData(data))
        
        let expectation = expectationWithDescription("GET clients")
        let params: [String: AnyObject] = ["page": "1"]
        var address: Address!
        
        Client.get(10, path: "address", parameters: params, completionHandler: { (response: Alamofire.Response<Address, NSError>) in
            if response.result.isSuccess {
                address = response.result.value!
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(30) { (error) in
            XCTAssert(address.id == 1)
            XCTAssert(address.street == "Street name")
            XCTAssert(address.number == 40)
        }
    }
    
}