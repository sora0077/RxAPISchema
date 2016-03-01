//
//  MultipartRequestSchema.swift
//  RxAPISchema
//
//  Created by 林達也 on 2016/02/26.
//  Copyright © 2016年 jp.sora0077. All rights reserved.
//

import Foundation
import Alamofire


public protocol MultipartRequestSchema: RequestSchema {
    
    func multipartBuilder() -> MultipartFormData -> Void
    
}

public extension MultipartRequestSchema {
    
    var method: HTTPMethod {
        return .POST
    }
}
