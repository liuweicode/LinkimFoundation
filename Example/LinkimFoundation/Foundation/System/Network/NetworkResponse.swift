//
//  NetworkResponse.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit

class NetworkResponse : NSObject {

    // 响应体数据
    var data:NSData?
    
    // 响应头
    var headers: [NSObject : AnyObject]?
}
