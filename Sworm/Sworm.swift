//
//  Sworm.swift
//  Sworm
//
//  Created by Wilbert Ribeiro on 30/10/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation
import Alamofire

class Sworm: ResponseObjectSerializable {
    var id: Int!
    var errors: Dictionary<String, Array<String>>?
    
    static var site: String!
    
    class func className() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    func className() -> String {
        return self.dynamicType.className()
    }
    
    class func resource() -> String? {
        return className().pluralize().snakeCase()
    }
    
    func resource() -> String {
        return self.dynamicType.resource()!
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
    
    class func get<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.get(nil, path: nil, parameters: parameters, completionHandler: completionHandler)
    }
    
    // MARK: Get collections
    
    class func get<T: ResponseCollectionSerializable>(parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        let url = self.mountResourceURL("")
        
        Alamofire.request(.GET, url, parameters: parameters).responseCollection  { (response: Response<[T], NSError>) in
            completionHandler(response)
        }
    }
    
    class func get<T: ResponseCollectionSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        let url = self.mountResourceURL(path)
        
        Alamofire.request(.GET, url, parameters: parameters).responseCollection  { (response: Response<[T], NSError>) in
            completionHandler(response)
        }
    }
    
    class func get<T: ResponseCollectionSerializable>(id: Int, path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        let url = self.mountResourceURL(id, path: path)
        
        print(url)
        
        Alamofire.request(.GET, url, parameters: parameters).responseCollection  { (response: Response<[T], NSError>) in
            completionHandler(response)
        }
    }
    
    // MARK: Creations
    
    class func create<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL()
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func create<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(path)
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func create<T: ResponseCollectionSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void) {
        let url = self.mountResourceURL(path)
        
        Alamofire.request(.POST, url, parameters: parameters).responseCollection { (response: Response<[T], NSError>) in
            completionHandler(response)
        }
    }
    
    class func create<T: ResponseObjectSerializable>(prefixes: [Sworm], parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        
        let prefixesArray: [String] = prefixes.map({ self.prefix($0) })
        let prefixesString = prefixesArray.joinWithSeparator("")
        
        let url = self.mountResourceURL(nil, path: nil, prefix: prefixesString)
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func create<T: ResponseObjectSerializable>(prefixes: [Sworm], parameters: [String: AnyObject], progressHandler: (Int64, Int64, Int64) -> Void, completionHandler: (Response<T, NSError>) -> Void) {
        
        let prefixesArray: [String] = prefixes.map({ self.prefix($0) })
        let prefixesString = prefixesArray.joinWithSeparator("")
        
        let url = self.mountResourceURL(nil, path: nil, prefix: prefixesString)
        
        Alamofire.request(.POST, url, parameters: parameters).progress{ (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
            progressHandler(bytesRead, totalBytesRead, totalBytesExpectedToRead)
            }.responseObject { (response: Response<T, NSError>) in
                completionHandler(response)
        }
    }
    
    class func create<T: ResponseCollectionSerializable>(prefixes: [Sworm], parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void) {
        
        let prefixesArray: [String] = prefixes.map({ self.prefix($0) })
        let prefixesString = prefixesArray.joinWithSeparator("")
        
        let url = self.mountResourceURL(nil, path: nil, prefix: prefixesString)
        
        Alamofire.request(.POST, url, parameters: parameters).responseCollection { (response: Response<[T], NSError>) in
            completionHandler(response)
        }
    }
    
    // MARK: Updates
    
    class func update<T: ResponseObjectSerializable>(id: Int, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id)
        
        print(parameters)
        
        Alamofire.request(.PUT, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func update<T: ResponseObjectSerializable>(id: Int, path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id, path: path)
        
        Alamofire.request(.PUT, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    // MARK: Deletions
    
    class func delete<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(nil, path: path)
        
        Alamofire.request(.DELETE, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func delete<T: ResponseObjectSerializable>(id: Int, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id)
        
        Alamofire.request(.DELETE, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func delete<T: ResponseObjectSerializable>(id: Int, path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id, path: path)
        
        Alamofire.request(.DELETE, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    // MARK: Utilities
    
    class func prefix(object: Sworm) -> String {
        let prefix: String = object.resource()
        return "\(prefix)/\(object.id)"
    }
    
    class func mountResourceURL(id: Int?, path: String?, prefix: String?) -> String {
        var baseURL = self.site!
        
        if let _prefix = prefix {
            baseURL += "/\(_prefix)"
        }
        
        baseURL += "/\(self.resource()!)"
        
        if let _id = id {
            baseURL += "/\(_id)"
        }
        
        if let _path = path {
            baseURL += "/\(_path)"
        }
        
        return baseURL
    }
    
    class func mountResourceURL(id: Int?, path: String?) -> String {
        return self.mountResourceURL(id, path: path, prefix: nil)
    }
    
    class func mountResourceURL(id: Int) -> String {
        return self.mountResourceURL(id, path: nil, prefix: nil)
    }
    
    class func mountResourceURL(path: String) -> String {
        return self.mountResourceURL(nil, path: path, prefix: nil)
    }
    
    class func mountResourceURL() -> String {
        return self.mountResourceURL(nil, path: nil, prefix: nil)
    }
    
    func isNewObject() -> Bool {
        if self.id == nil {
            return true
        } else {
            return false
        }
    }
    
    
}
    