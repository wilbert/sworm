//
//  Sworm+InstanceMethods.swift
//  Sworm
//
//  Created by Wilbert on 05/11/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation
import Alamofire

extension Sworm {
    
    // MARK: GET
    
    func get<T: ResponseObjectSerializable>(path: String, completionHandler: (Response<T, NSError>) -> Void) {
        self.dynamicType.get(self.id, completionHandler: completionHandler)
    }
    
    func get<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.dynamicType.get(self.id, parameters: parameters, completionHandler: completionHandler)
    }
    
    // MARK: GET COLLECTIONS
    
    func get<T: ResponseCollectionSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void ) {
        return self.dynamicType.get(self.id, path: path, parameters: parameters, completionHandler: completionHandler)
    }
    
    // MARK: CREATE
    
    func create<T: ResponseCollectionSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<[T], NSError>) -> Void) {
        let newPath = "\(self.id)/\(path)"
        self.dynamicType.create(newPath, parameters: parameters, completionHandler: completionHandler)
    }
    
    func create<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        let newPath = "\(self.id)/\(path)"
        self.dynamicType.create(newPath, parameters: parameters, completionHandler: completionHandler)
    }
    
    // MARK: UPDATE
    
    func update<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.dynamicType.update(self.id, parameters: parameters, completionHandler: completionHandler)
    }
    
    func update<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.dynamicType.update(self.id, path: path, parameters: parameters, completionHandler: completionHandler)
    }
    
    
    // MARK: DELETE
    
    func delete<T: ResponseObjectSerializable>(completionHandler: (Response<T, NSError>) -> Void) {
        self.dynamicType.delete(self.id, parameters: Dictionary<String, AnyObject>(), completionHandler: completionHandler)
    }
    
    func delete<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        
        self.dynamicType.delete(self.id, parameters: parameters, completionHandler: completionHandler)
    }
    
    func delete<T: ResponseObjectSerializable>(path: String, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        self.dynamicType.delete(self.id, path: path, parameters: parameters, completionHandler: completionHandler)
    }
    
}