//
//  NetworkRequest.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit

public class NetworkRequest : NSObject {

    // 请求地址
    public var url:String?
    
    // 请求参数
    public var params: [String:AnyObject]?
    
    // 请求体数据
    public var data:NSData?
    
    // 请求头
    public var headers: [NSObject : AnyObject]?
    
    // 请求类型 POST / GET
    public var method:NetworkRequestMethod = .POST
    
}
