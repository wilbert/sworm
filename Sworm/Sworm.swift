//
//  Sworm.swift
//  Sworm
//
//  Created by Wilbert Ribeiro on 30/10/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation


import Foundation
import Alamofire
import Pluralize_swift

class Sworm: ResponseObjectSerializable {
    var id: Int!
    var errors: Dictionary<String, Array<String>>?

    static var site: String!
    
    class func resource() -> String? {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!.lowercaseString.pluralize()
    }
    
    // MARK: Initializers
    
    @objc required init(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
    }
    
    init() {
        
    }
    
    // MARK: Get objects
    
    class func get<T: ResponseObjectSerializable>(id: Int?, path: String?, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id, path: path)
        
        Alamofire.request(.GET, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
        
    class func get<T: ResponseObjectSerializable>(id: Int, completionHandler: (Response<T, NSError>) -> Void) {
        self.get(id, path: nil, parameters: Dictionary<String, AnyObject>(), completionHandler: completionHandler)
    }
    
    class func get<T: ResponseObjectSerializable>(id: Int, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.get(id, path: nil, parameters: parameters, completionHandler: completionHandler)
    }
    
    // MARK: Get collections
    
    class func get<T: ResponseCollectionSerializable>(parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        return self.get("", parameters: parameters, completionHandler: completionHandler)
    }
    
    class func get<T: ResponseCollectionSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        let url = self.mountResourceURL(nil, path: path)
        
        Alamofire.request(.GET, url, parameters: parameters).responseCollection  { (response: Response<[T], NSError>) in
            completionHandler(response)
        }
    }
    
    // MARK: Creatios
    
    class func create<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.create(nil, parameters: parameters, completionHandler: completionHandler)
    }
    
    class func create<T: ResponseObjectSerializable>(path: String?, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(nil, path: path)
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    // MARK: Deletions
    
    class func delete<T: ResponseObjectSerializable>(id: Int, path: String!, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id, path: path)
        
        Alamofire.request(.DELETE, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func delete<T: ResponseObjectSerializable>(id: Int, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id, path: nil)
        
        Alamofire.request(.DELETE, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    // MARK: Utilities
    
    class func mountResourceURL(id: Int?, path: String?) -> String {
        var baseURL = self.site!
        
        
        baseURL += "/\(self.resource()!)"
        
        if let _id = id {
            baseURL += "/\(_id)"
        }
        if let _path = path {
            baseURL += "/\(_path)"
        }
        
        return baseURL
    }
    
    class func mountResourceURL(id: Int) -> String {
        return self.mountResourceURL(id, path: nil)
    }
    
    class func mountResourceURL(path: String) -> String {
        return self.mountResourceURL(nil, path: path)
    }
    
    class func mountResourceURL() -> String {
        return self.mountResourceURL(nil, path: nil)
    }
    
    func isNewObject() -> Bool {
        if self.id == nil {
            return true
        } else {
            return false
        }
    }
}
    