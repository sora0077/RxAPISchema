//
//  DebugRequestType.swift
//  RxAPISchema
//
//  Created by 林達也 on 2016/02/29.
//  Copyright © 2016年 jp.sora0077. All rights reserved.
//

import Foundation
import Alamofire

public protocol DebugRequestType {
    
    func printRequest(request: Request)
    
    func printResponse(responseString: CustomDebugStringConvertible)
}

public extension DebugRequestType {
    
    func printRequest(request: Request) {
        print(request.debugDescription)
    }
    
    func printResponse(responseString: CustomDebugStringConvertible) {
        print(responseString)
    }
}

public struct DebugRequest<Schema: RequestSchema>: DebugRequestType {
    
    let schema: Schema
    
    public init(_ schema: Schema) {
        self.schema = schema
    }
}
