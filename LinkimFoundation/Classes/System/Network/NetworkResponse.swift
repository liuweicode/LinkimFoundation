//
//  NetworkResponse.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit

public class NetworkResponse : NSObject {

    // 响应数据
    public var data:NSData?
    
    // 响应头
    public var headers: [NSObject : AnyObject]?
}
