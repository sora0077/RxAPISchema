//: Playground - noun: a place where people can play

import UIKit
import RxAPISchema
import Alamofire


let client = Client()

struct Test: RequestSchema, JSONSerializer {
    
    typealias Response = String
    typealias Expect = [String: AnyObject]?
    
    var method: HTTPMethod {
        return .GET
    }
    
    var path: String = "https://httpbin.org/get"
    
    func response(request: NSURLRequest?, response: NSHTTPURLResponse?, object: Expect) throws -> Response {
        return object?.keys.first ?? ""
    }
}

client.request(DebugRequest(schema: Test())).subscribeNext { (res) -> Void in
    print(res)
    
    print("done")
}

import XCPlayground


XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
