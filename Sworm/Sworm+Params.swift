//
//  Sworm+Params.swift
//  Sworm
//
//  Created by Wilbert on 02/11/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation

extension Sworm {
    func toParams() -> Dictionary<String, Any> {
        //        var params = Dictionary<String, Any>()
        //
        //        let mirror = Mirror(reflecting: self)
        //        let superClassMirror = mirror.superclassMirror()!
        //
        //        params = self.childrenDictionary(superClassMirror)
        //        params.update(self.childrenDictionary(mirror))
        //
        //        return params
        return Dictionary<String, Any>()
    }
    
    private func childrenDictionary(mirror: Mirror) -> Dictionary<String, Any> {
        var params = Dictionary<String, Any>()
        
        for child in mirror.children {
            params[child.label!] = child.value
        }
        
        return params
    }
}