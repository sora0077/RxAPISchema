
//
//  RequestSchema.swift
//  RxAPISchema
//
//  Created by 林達也 on 2016/02/21.
//  Copyright © 2016年 jp.sora0077. All rights reserved.
//

import Foundation
import Alamofire

/**
 *  RequestSchema
 */
public protocol RequestSchema {
    
    /// Response
    typealias Response
    
    /// Expect
    typealias Expect
    
    /// default = nil
    var method: HTTPMethod { get }
    
    /// default = nil
    var baseURL: NSURL? { get }
    
    /// e.g) /path/to/schema or http://host/path/to/schema
    var path: String { get }
    
    /// default = nil
    var headers: [String: String]? { get }
    
    /// default = nil
    var parameters: [String: AnyObject]? { get }
    
    /// default = nil
    var timeoutInterval: NSTimeInterval? { get }
    
    /// default = ni;
    var statusCode: Set<Int>? { get }
    
    /// default = nil
    var contentType: Set<String>? { get }
    
    /// default = .URL
    var requestEncoding: RequestEncoding { get }
    
    /**
     transform to response
     
     - parameter request:
     - parameter response:
     - parameter object:
     
     - throws:
     
     - returns:
     */
    func response(request: NSURLRequest?, response: NSHTTPURLResponse?, object: Expect) throws -> Response
}


public extension RequestSchema {
    
    var baseURL: NSURL? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var timeoutInterval: NSTimeInterval? {
        return nil
    }
    
    var statusCode: Set<Int>? {
        return nil
    }
    
    var contentType: Set<String>? {
        return nil
    }
    
    var requestEncoding: ParameterEncoding {
        return .URL
    }
}
