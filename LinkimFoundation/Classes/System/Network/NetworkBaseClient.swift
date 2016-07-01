//
//  NetworkBaseClient.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit
import Alamofire

//public typealias NetworkSuccessBlock = (message:NetworkMessage) -> Void
//public typealias NetworkFailBlock = (message:NetworkMessage,error:NSError) -> Void

public typealias NetworkCompletionHandler = (message:NetworkMessage) -> Void

public enum NetworkRequestMethod : Int {
    case POST, GET
}

//public protocol NetworkClientProtocol {
//    func POST(successCallback successCallback:()->Void, failureCallback failureCallback:(error:NSError)->Void) -> Request;
//    func GET(successCallback successCallback:()->Void, failureCallback failureCallback:(error:NSError)->Void) -> Request;
//}

var clientNO:UInt = 1

public class NetworkBaseClient : NSObject {
    
    // 网络数据封装
    public var message: NetworkMessage?
    
    // 回调者
    public var target:NSObject
    
    // 超时时间
    let networkTimeout:NSTimeInterval = 20
    
    // 请求任务
    var task:Request?
    
    // 当前任务标识
    var clientId:NSNumber?
    
    // 回调
    var completionHandler:NetworkCompletionHandler?
    
    
    public init(target obj:NSObject) {
        target = obj
        super.init()
        clientNO = clientNO + 1
        clientId = NSNumber(unsignedInteger: clientNO)
        NetworkClientManager.sharedInstance.addClient(client: self, forClientId: clientId!)
    }
    
    public func send(method method:NetworkRequestMethod, params params:[String:AnyObject], url url:String, completionHandler completionHandler:NetworkCompletionHandler) -> NSNumber? {
        self.message = NetworkMessage(url: url, params: params, method: method)
        self.completionHandler = completionHandler
        return self.send()
    }
    
    func send() -> NSNumber?
    {
        switch self.message!.request!.method {
            case .POST:
                self.task = self.POST()
            case .GET:
                self.task = self.GET()
        }
        return self.clientId
    }
    
    // 取消请求
    func cancel() {
        self.task?.cancel()
    }
    
    // 获取调用者
    func requestReceive() -> NSObject {
       return self.target
    }
    
    
    public func POST() -> Request {
        return Alamofire.request(.POST, self.message!.request!.url!,
            parameters:self.message?.request?.params,
            encoding: Alamofire.ParameterEncoding.JSON,
            headers: nil ).validate().response(completionHandler: {[weak self] (request, response, data, error) in
                // 设置请求头信息
                self?.message?.request?.headers = request?.allHTTPHeaderFields
                // 设置响应信息
                var networkResponse = NetworkResponse()
                networkResponse.data = data
                networkResponse.headers = response?.allHeaderFields
                self?.message?.response = networkResponse
                // 是否有错误
                if let responseError = error{
                    self?.message?.networkError = NetworkError.httpError(responseError.code, responseError.description)
                }
                self?.completionHandler?(message: (self?.message)!)
                NetworkClientManager.sharedInstance.removeClientWithId((self?.clientId!)!)
                })
    }
    
    public func GET() -> Request {
        return Alamofire.request(.POST, self.message!.request!.url!,
            parameters:self.message?.request?.params,
            encoding: Alamofire.ParameterEncoding.JSON,
            headers: nil ).validate().response(completionHandler: {[weak self] (request, response, data, error) in
                
                var networkResponse = NetworkResponse()
                networkResponse.data = data
                networkResponse.headers = response?.allHeaderFields
                self?.message?.response = networkResponse
                
                self?.completionHandler?(message: (self?.message)!)
                NetworkClientManager.sharedInstance.removeClientWithId((self?.clientId!)!)
            })
    }
}
