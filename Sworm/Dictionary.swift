//
//  Dictionary.swift
//  Sworm
//
//  Created by Wilbert on 02/11/15.
//  Copyright © 2015 Wilbert Ribeiro. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
