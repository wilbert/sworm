
//  Networking.swift
//  espnsync
//
//  Created by Wilbert Kelyson Gomes Ribeiro on 4/20/15.
//  Copyright (c) 2015 Sworm.
//

import Foundation
import Alamofire

/**
 * Response Object Serializer Extension
 */

public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}

extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let response = response
                {
                    if response.statusCode >= 500 {
                        let failureReason = "Response error"
                        let error = Error.errorWithCode(.StatusCodeValidationFailed, failureReason: failureReason)
                        return .Failure(error)
                    } else {
                        if let responseObject = T(response: response, representation: value) {
                            return .Success(responseObject)
                        } else {
                            let failureReason = "Response collection could not be serialized due to nil response"
                            let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                            return .Failure(error)
                        }
                    }
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

/**
 * Response Object Collection Extension
 */

public protocol ResponseCollectionSerializable {
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let response = response {
                    if response.statusCode >= 500 {
                        let failureReason = "Response error"
                        let error = Error.errorWithCode(.StatusCodeValidationFailed, failureReason: failureReason)
                        return Result.Failure(error)
                    } else {
                        return Result.Success(T.collection(response: response, representation: value))
                    }
                } else {
                    let failureReason = "Response collection could not be serialized due to nil response"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
