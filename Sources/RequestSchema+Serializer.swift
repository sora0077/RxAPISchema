//
//  RequestSchema+Serializer.swift
//  RxAPISchema
//
//  Created by 林達也 on 2016/02/21.
//  Copyright © 2016年 jp.sora0077. All rights reserved.
//

import Foundation
import Alamofire


public protocol DataSerializer: ResponseSerializerType {}
public extension DataSerializer {
    
    var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Result<NSData, NSError> {
        return Request.dataResponseSerializer().serializeResponse
    }
}

public protocol StringSerializer: ResponseSerializerType {}
public extension StringSerializer {
    
    var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Result<String, NSError> {
        return Request.stringResponseSerializer().serializeResponse
    }
}

public protocol JSONSerializer: ResponseSerializerType {}
public extension JSONSerializer {
    
    var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Result<AnyObject, NSError> {
        return Request.JSONResponseSerializer().serializeResponse
    }
}

public protocol PropertyListSerializer: ResponseSerializerType {}
public extension PropertyListSerializer {
    
    var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Result<AnyObject, NSError> {
        return Request.propertyListResponseSerializer().serializeResponse
    }
}
