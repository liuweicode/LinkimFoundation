//
//  NetworkClientManager.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit

public class NetworkClientManager: NSObject {

    // 单例类
    public static let sharedInstance = NetworkClientManager()
    
    // 私有化init方法
    private override init() {}
    
    // 请求任务
    public lazy var requests = [NSNumber:NetworkBaseClient]()
    
    /**
     添加请求到管理队列
     
     - parameter aClient:  单次请求
     - parameter clientId: 标识
     */
    func addClient(client aClient:NetworkBaseClient, forClientId clientId:NSNumber)
    {
       self.requests[clientId] = aClient
    }
    
    /**
     根据标识移除请求
     
     - parameter clientId: 标识
     */
    func removeClientWithId(clientId:NSNumber)
    {
        let client = self.requests[clientId]
        client?.cancel()
        self.requests.removeValueForKey(clientId)
    }
    
    /**
     根据回调者移除请求
     
     - parameter receive: 回调对象
     */
    func removeClientWithReceive(receive:NSObject)
    {
        var clientId:NSNumber?
        for number in self.requests.keys {
            var client = self.requests[number]!
            if client.requestReceive() == receive {
                clientId = client.clientId
                break
            }
        }
        
        if let currentClientId = clientId where currentClientId.unsignedIntegerValue != 0 {
            self.removeClientWithId(currentClientId)
        }
    }
    
    /**
     移除所有请求
     */
    func removeAllClient()
    {
        for number in self.requests.keys {
            if let client = self.requests[number]
            {
                client.cancel()
            }
        }
        self.requests.removeAll()
    }
    
}
