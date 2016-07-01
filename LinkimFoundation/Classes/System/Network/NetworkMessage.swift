//
//  NetworkMessage.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit

// 网络数据封装
public class NetworkMessage: NSObject {

    // 请求数据
    public var request: NetworkRequest?
    
    // 响应的数据
    public var response: NetworkResponse?
    
    // 错误
    public var networkError: NetworkError?
    
    // 用户自定义数据,与网络数据无关
    public var userInfo: AnyObject?
    
    // 数据标识
    public var tag: NSInteger?
    
    init(url url:String, params params:[String:AnyObject],method method:NetworkRequestMethod) {
        request = NetworkRequest()
        request!.url = url
        request!.params = params
        request?.method = method
    }
}
