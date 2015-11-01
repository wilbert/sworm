//
//  DummyResourceTests+GetCollections.swift
//  Sworm
//
//  Created by Wilbert on 01/11/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation
import XCTest
import Mockingjay
import Alamofire


class DummyResourcesTestsCollections: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        Sworm.site = "http://www.site.com"
    }
    
    func testingGetCollection() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("clients", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(uri("/clients"), builder: jsonData(data))
        
        let expectation = expectationWithDescription("GET clients")
        let params: [String: AnyObject] = ["page": "1"]
        var clients: [Client]!
        
        Client.get(params, completionHandler: { (response: Alamofire.Response<[Client], NSError>) in
            if response.result.isSuccess {
                clients = response.result.value!
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(30) { (error) in
            XCTAssert(clients.count == 2)
        }
    }
    
    func testingGetCollectionWithPath() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("active_clients", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(uri("/clients/actives"), builder: jsonData(data))
        
        let expectation = expectationWithDescription("GET clients")
        let params: [String: AnyObject] = ["page": "1"]
        var clients: [Client]!
        
        Client.get("actives", parameters: params, completionHandler: { (response: Alamofire.Response<[Client], NSError>) in
            if response.result.isSuccess {
                clients = response.result.value!
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(30) { (error) in
            XCTAssert(clients.count == 1)
        }
    }

}