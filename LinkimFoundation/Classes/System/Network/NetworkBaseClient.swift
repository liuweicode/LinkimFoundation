//
//  NetworkBaseClient.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit
import Alamofire

public typealias NetworkCompletionHandler = (message:NetworkMessage) -> Void

public enum NetworkRequestMethod : Int {
    case POST, GET
}

var clientNO:UInt = 1

public class NetworkBaseClient : NSObject {
    
    // 网络数据封装
    public lazy var message = NetworkMessage()
    
    // 回调者
    private var target:NSObject
    
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
        self.message.request.url = url
        self.message.request.params = params
        self.message.request.method = method
        self.completionHandler = completionHandler
        return self.send()
    }
    
    func send() -> NSNumber?
    {
        switch self.message.request.method {
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
        return Alamofire.request(.POST, self.message.request.url!,
            parameters:[:],
            encoding: Alamofire.ParameterEncoding.Custom({ (convertible, params) -> (NSMutableURLRequest, NSError?) in
                
                var data:NSData?
                do{
                    data = try NSJSONSerialization.dataWithJSONObject(self.message.request.params!, options: NSJSONWritingOptions.init(rawValue: 0))
                }catch{
                    print("--------请求参数报错-------")
                }
                let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
                mutableRequest.HTTPBody = data
                return (mutableRequest, nil)
            }),
            headers: nil ).validate().response(completionHandler: {[weak self] (request, response, data, error) in
                // 设置请求头信息
                self?.message.request.headers = request?.allHTTPHeaderFields
                // 设置响应信息
                self?.message.response.data = data
                self?.message.response.headers = response?.allHeaderFields
                // 是否有错误
                if let responseError = error{
                    self?.message.networkError = NetworkError.httpError(responseError.code, responseError.description)
                }
                self?.completionHandler?(message: (self?.message)!)
                NetworkClientManager.sharedInstance.removeClientWithId((self?.clientId!)!)
                })
    }
    
    public func GET() -> Request {
        return Alamofire.request(.GET, self.message.request.url!,
            parameters:self.message.request.params,
            encoding: Alamofire.ParameterEncoding.JSON,
            headers: nil ).validate().response(completionHandler: {[weak self] (request, response, data, error) in
                // 设置请求头信息
                self?.message.request.headers = request?.allHTTPHeaderFields
                // 设置响应信息
                var networkResponse = NetworkResponse()
                networkResponse.data = data
                networkResponse.headers = response?.allHeaderFields
                self?.message.response = networkResponse
                // 是否有错误
                if let responseError = error{
                    self?.message.networkError = NetworkError.httpError(responseError.code, responseError.description)
                }
                self?.completionHandler?(message: (self?.message)!)
                NetworkClientManager.sharedInstance.removeClientWithId((self?.clientId!)!)
                })
    }
}
