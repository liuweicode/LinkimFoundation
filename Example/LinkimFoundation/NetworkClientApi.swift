//
//  NetworkClientApi.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/6/30.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation
import Alamofire

class NetworkClientApi{
    
    class func POST(target target:NSObject,params:[String:AnyObject], url:String, successCallback: (message:NetworkMessage) -> Void, failureCallback: (message:NetworkMessage) -> Void)
    {
        
        let client = NetworkBaseClient(target: target)
        client.send(method: .POST, params: params, url: url) { (message) in
            if let _ = message.networkError
            {
                // 有网络错误
                failureCallback(message: message)
            }else{
                if let _ = message.response.data
                {
                    // 解析data
                    successCallback(message: message)
                }else{
                    message.networkError = NetworkError.dataError(1,"数据有误")
                    failureCallback(message: message)
                }
            }
        }
    }
    
}
