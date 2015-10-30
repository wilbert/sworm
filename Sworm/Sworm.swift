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

protocol ActiveModel {
    var id: Int! { get set }
    
    static func resourceName() -> String
    func resourceName() -> String
}

class BaseModel: ActiveModel, ResponseObjectSerializable {
    var id: Int!
    var errors: Dictionary<String, Array<String>>?
    
    class func resourceName() -> String {
        return "base"
    }
    
    func resourceName() -> String {
        return "base"
    }
    
    @objc required init(response: NSHTTPURLResponse, representation: AnyObject) {
        
    }
    
    init(){
        
    }
    
    class func fetch<T: ResponseObjectSerializable>(path: String!, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(path)
        
        Alamofire.request(.GET, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func delete<T: ResponseObjectSerializable>(path: String!, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(path)
        
        Alamofire.request(.DELETE, url, parameters: parameters).responseObject { (response: Response<T, NSError>) in
            completionHandler(response)
        }
    }
    
    class func fetch<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        _ = self.mountResourceURL()
        self.fetch(nil, parameters: parameters, completionHandler: completionHandler)
    }
    
    class func fetchResponse<T: ResponseObjectSerializable>(id: Int, completionHandler: (Response<T, NSError>) -> Void) {
        self.fetchResponse(id, parameters: Dictionary<String, AnyObject>(), completionHandler: completionHandler)
    }
    
    class func fetchResponse<T: ResponseObjectSerializable>(id: Int, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(id)
        
        Alamofire.request(.GET, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    class func fetchAll<T: ResponseCollectionSerializable>(parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        return self.fetchAll("", parameters: parameters, completionHandler: completionHandler)
    }
    
    class func fetchAll<T: ResponseCollectionSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        let url = self.mountResourceURL(path)
        
        Alamofire.request(.GET, url, parameters: parameters).responseCollection  { (generics: Response<[T], NSError>) in
            completionHandler(generics)
        }
    }
    
    class func create<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL()
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    class func create<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = self.mountResourceURL(path)
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    class func mountResourceURL(path: String?) -> String {
        var url = self.mountResourceURL()
        
        if path != nil && path != "" {
            url = url + "/" + path!
        }
        
        return url
    }
    
    class func mountResourceURL() -> String! {
        let className = self.resourceName()
        return Application.apiURL + Application.apiVersionV1 + className
    }
    
    class func mountResourceURL(id: Int!) -> String! {
        return self.mountResourceURL() + "/\(id)"
    }
    
    func mountResourceURL() -> String! {
        let className = self.resourceName()
        return Application.apiURL + Application.apiVersionV1 + className
    }
    
    func mountResourceURL(id: Int!) -> String! {
        return self.mountResourceURL() + "/\(id)"
    }
    
    func fetchAll<T: ResponseCollectionSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        let url = mountResourceURL(path, id: self.id)
        
        Alamofire.request(.GET, url, parameters: parameters).responseCollection  { (generics: Response<[T], NSError>) in
            completionHandler(generics)
        }
    }
    
    func create<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = mountResourceURL()
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
        
    }
    
    func create<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = mountResourceURL(path, id: self.id)
        
        Alamofire.request(.POST, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    func create<T: ResponseCollectionSerializable>(path: String!, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void) {
        let url = mountResourceURL(path, id: self.id)
        
        Alamofire.request(.POST, url, parameters: parameters).responseCollection { (generic: Response<[T], NSError>) in
            completionHandler(generic)
        }
    }
    
    func update<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.update(nil, parameters: parameters, completionHandler: completionHandler)
    }
    
    func update<T: ResponseObjectSerializable>(path: String!, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = mountResourceURL(path, id: self.id)
        
        Alamofire.request(.PUT, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    func patch<T: ResponseObjectSerializable>(path: String!, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = mountResourceURL(path, id: self.id)
        
        Alamofire.request(.PATCH, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    func delete<T: ResponseObjectSerializable>(path: String!, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let url = mountResourceURL(path, id: self.id)
        
        Alamofire.request(.DELETE, url, parameters: parameters).responseObject { (generic: Response<T, NSError>) in
            completionHandler(generic)
        }
    }
    
    private func mountResourceURL(path: String?, id: Int) -> String {
        var url = self.mountResourceURL(id)
        
        if path != nil && path != "" {
            url = url + "/" + path!
        }
        
        return url
    }
    
    func isNewObject() -> Bool {
        if self.id == nil {
            return true
        } else {
            return false
        }
    }
}
    