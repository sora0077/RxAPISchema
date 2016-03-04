//
//  Client.swift
//  RxAPISchema
//
//  Created by 林達也 on 2016/02/21.
//  Copyright © 2016年 jp.sora0077. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public final class Client {
    
    private let manager: Manager
    
    public init(manager: Manager) {
        self.manager = manager
    }
    
}

public extension Client {
    
    convenience init(configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()) {
        self.init(manager: Manager(configuration: configuration))
    }
}

public extension Client {
    
    func request<Schema: RequestSchema where Schema: ResponseSerializerType>(schema: Schema) -> Observable<Schema.Response> {
        
        do {
            return self.parseResponse(schema, request: try self.makeRequest(schema))
        } catch {
            return Observable.error(error)
        }
    }
    
    func request<Schema: RequestSchema, T where Schema: ResponseSerializerType, Schema.Expect == T?>(schema: Schema) -> Observable<Schema.Response> {
        
        do {
            return self.parseResponse(schema, request: try self.makeRequest(schema))
        } catch {
            return Observable.error(error)
        }
    }
}

public extension Client {
    
    func request<Schema: MultipartRequestSchema where Schema: ResponseSerializerType>(schema: Schema) -> Observable<Schema.Response> {
        
        return self.prepareMultipart(schema).flatMap { req in
            self.parseResponse(schema, request: req)
        }
    }
    
    func request<Schema: MultipartRequestSchema, T where Schema: ResponseSerializerType, Schema.Expect == T?>(schema: Schema) -> Observable<Schema.Response> {
        
        return self.prepareMultipart(schema).flatMap { req in
            self.parseResponse(schema, request: req)
        }
    }
}

public extension Client {
    
    func request<Schema: DebugRequestType where Schema: RequestSchema, Schema: ResponseSerializerType>(schema: Schema) -> Observable<Schema.Response> {
        
        do {
            let req = try self.makeRequest(schema)
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(schema, request: req)) { result, res in
                    schema.printRequest(req)
                    schema.printResponse(result.debugDescription)
                    return res
                }
        } catch {
            return Observable.error(error)
        }
    }
    
    func request<Schema: DebugRequestType, T where Schema: RequestSchema, Schema: ResponseSerializerType, Schema.Expect == T?>(schema: Schema) -> Observable<Schema.Response> {
        
        do {
            let req = try self.makeRequest(schema)
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(schema, request: req)) { result, res in
                    schema.printRequest(req)
                    schema.printResponse(result.debugDescription)
                    return res
                }
        } catch {
            return Observable.error(error)
        }
    }
    
    func request<Schema: RequestSchema where Schema: ResponseSerializerType>(debugger: DebugRequest<Schema>) -> Observable<Schema.Response> {
        
        do {
            let req = try self.makeRequest(debugger.schema)
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(debugger.schema, request: req)) { result, res in
                    debugger.printRequest(req)
                    debugger.printResponse(result.debugDescription)
                    return res
                }
        } catch {
            return Observable.error(error)
        }
    }
    
    func request<Schema: RequestSchema, T where Schema: ResponseSerializerType, Schema.Expect == T?>(debugger: DebugRequest<Schema>) -> Observable<Schema.Response> {
        
        do {
            let req = try self.makeRequest(debugger.schema)
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(debugger.schema, request: req)) { result, res in
                    debugger.printRequest(req)
                    debugger.printResponse(result.debugDescription)
                    return res
                }
        } catch {
            return Observable.error(error)
        }
    }
}

public extension Client {
    
    func request<Schema: DebugRequestType where Schema: MultipartRequestSchema, Schema: ResponseSerializerType>(schema: Schema) -> Observable<Schema.Response> {
        
        return self.prepareMultipart(schema).flatMap { req -> Observable<Schema.Response> in
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(schema, request: req)) { result, res in
                    schema.printRequest(req)
                    schema.printResponse(result.debugDescription)
                    return res
                }
        }
    }
    
    func request<Schema: DebugRequestType, T where Schema: MultipartRequestSchema, Schema: ResponseSerializerType, Schema.Expect == T?>(schema: Schema) -> Observable<Schema.Response> {
        
        return self.prepareMultipart(schema).flatMap { req -> Observable<Schema.Response> in
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(schema, request: req)) { result, res in
                    schema.printRequest(req)
                    schema.printResponse(result.debugDescription)
                    return res
                }
        }
    }
    
    func request<Schema: MultipartRequestSchema where Schema: ResponseSerializerType>(debugger: DebugRequest<Schema>) -> Observable<Schema.Response> {
        
        return self.prepareMultipart(debugger.schema).flatMap { req -> Observable<Schema.Response> in
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(debugger.schema, request: req)) { result, res in
                    debugger.printRequest(req)
                    debugger.printResponse(result.debugDescription)
                    return res
                }
        }
    }
    
    func request<Schema: MultipartRequestSchema, T where Schema: ResponseSerializerType, Schema.Expect == T?>(debugger: DebugRequest<Schema>) -> Observable<Schema.Response> {
        
        return self.prepareMultipart(debugger.schema).flatMap { req -> Observable<Schema.Response> in
            let result: Observable<Response<String, NSError>> = Observable.create { subscriber in
                req.responseString { res in
                    subscriber.onNext(res)
                    subscriber.onCompleted()
                }
                return NopDisposable.instance
            }
            return Observable
                .zip(result, self.parseResponse(debugger.schema, request: req)) { result, res in
                    debugger.printRequest(req)
                    debugger.printResponse(result.debugDescription)
                    return res
                }
        }
    }
}

private extension Client {
    
    func prepareMultipart<Schema: MultipartRequestSchema>(schema: Schema) -> Observable<Request> {
        
        return Observable.create { subscriber in
            
            do {
                self.manager.upload(
                    try self.makeURLRequest(schema),
                    multipartFormData: schema.multipartBuilder(),
                    encodingCompletion: { result in
                        switch result {
                        case let .Success(request, _, _):
                            if let statusCode = schema.statusCode {
                                request.validate(statusCode: statusCode)
                            }
                            if let contentType = schema.contentType {
                                request.validate(contentType: contentType)
                            }
                            subscriber.onNext(request)
                            subscriber.onCompleted()
                        case let .Failure(error):
                            subscriber.onError(error)
                        }
                })
                
                return NopDisposable.instance
            } catch {
                subscriber.onError(error)
                
                return NopDisposable.instance
            }
        }
    }
    
    func parseResponse<Schema: RequestSchema where Schema: ResponseSerializerType>(schema: Schema, request: Request) -> Observable<Schema.Response> {
        
        return Observable.create { subscriber in
            
            request.response(responseSerializer: schema) { res in
                switch res.result {
                case .Success(let value):
                    do {
                        let response = try schema.response(res.request, response: res.response, object: value as! Schema.Expect)
                        subscriber.onNext(response)
                        subscriber.onCompleted()
                    } catch {
                        subscriber.onError(error)
                    }
                case .Failure(let error):
                    subscriber.onError(error)
                }
            }
            
            return AnonymousDisposable {
                request.cancel()
            }
        }
    }
    
    func parseResponse<Schema: RequestSchema, T where Schema: ResponseSerializerType, Schema.Expect == T?>(schema: Schema, request: Request) -> Observable<Schema.Response> {
        
        return Observable.create { subscriber in
            
            request.response(responseSerializer: schema) { res in
                switch res.result {
                case .Success(let value):
                    do {
                        let response = try schema.response(res.request, response: res.response, object: value as? T)
                        subscriber.onNext(response)
                        subscriber.onCompleted()
                    } catch {
                        subscriber.onError(error)
                    }
                case .Failure(let error):
                    subscriber.onError(error)
                }
            }
            
            return AnonymousDisposable {
                request.cancel()
            }
        }
    }
    
    func makeURLRequest<Schema: RequestSchema>(schema: Schema) throws -> NSURLRequest {
        
        let (request, error) = schema.requestEncoding.encode({
            let request = NSMutableURLRequest(URL: NSURL(string: schema.path, relativeToURL: schema.baseURL)!)
            request.HTTPMethod = schema.method.rawValue
            if let headers = schema.headers {
                for (k, v) in headers {
                    request.addValue(v, forHTTPHeaderField: k)
                }
            }
            
            if let timeoutInterval = schema.timeoutInterval {
                request.timeoutInterval = timeoutInterval
            }
            return request
            }(),
            parameters: schema.parameters
        )
        
        if let error = error {
            throw error
        }
        
        return request
    }
    
    func makeRequest<Schema: RequestSchema>(schema: Schema) throws -> Request {
        
        let req = manager.request(try makeURLRequest(schema))
        
        if let statusCode = schema.statusCode {
            req.validate(statusCode: statusCode)
        }
        if let contentType = schema.contentType {
            req.validate(contentType: contentType)
        }
        
        return req
    }
}
