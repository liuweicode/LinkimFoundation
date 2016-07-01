//
//  NetworkRequest.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit

class NetworkRequest : NSObject {

    // 请求地址
    var url:String?
    
    // 请求参数
    var params: [String:AnyObject]?
    
    // 请求体数据
    var data:NSData?
    
    // 请求头
    var headers: [String : String]?
    
    // 请求类型 POST / GET
    var method:NetworkRequestMethod = .POST
    
}
