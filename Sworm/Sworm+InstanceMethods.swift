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
        
        return self.dynamicType.get(path, parameters: parameters, completionHandler: completionHandler)
    }
    
    // MARK: CREATE

    func create<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        var params = toParams() as! Dictionary<String, AnyObject>
        
        params.update(parameters)
        
        self.create(params, completionHandler: completionHandler)
    }
    
    func create<T: ResponseObjectSerializable>(completionHandler: (Response<T, NSError>) -> Void) {
        let params = toParams() as! Dictionary<String, AnyObject>
        
        self.dynamicType.create(params, completionHandler: completionHandler)
    }
    
    // MARK: UPDATE
    
    func update<T: ResponseObjectSerializable>(id: Int, completionHandler: (Response<T, NSError>) -> Void) {
        
        let params = toParams() as! Dictionary<String, AnyObject>
        
        self.dynamicType.update(self.id, parameters: params, completionHandler: completionHandler)
    }
    
    func update<T: ResponseObjectSerializable>(id: Int, parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
        
        var params = toParams() as! Dictionary<String, AnyObject>

        params.update(parameters)
        
        self.dynamicType.update(self.id, parameters: params, completionHandler: completionHandler)
    }

    
    // MARK: DELETE 
    
    func delete<T: ResponseObjectSerializable>(completionHandler: (Response<T, NSError>) -> Void) {
        self.dynamicType.delete(self.id, parameters: Dictionary<String, AnyObject>(), completionHandler: completionHandler)
    }

    
    func delete<T: ResponseObjectSerializable>(parameters: [String: AnyObject], completionHandler: (Response<T, NSError>) -> Void) {
    
        self.dynamicType.delete(self.id, parameters: parameters, completionHandler: completionHandler)
    }

}