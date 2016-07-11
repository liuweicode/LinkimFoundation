//
//  NSNotification+Extension.swift
//  Happilitt
//
//  Created by 刘伟 on 16/4/18.
//  Copyright © 2016年 上海凌晋信息技术有限公司. All rights reserved.
//

import Foundation

public extension NSNotification
{
    /**
     比对当前通知对象是否是指定通知
     
     - parameter name: 通知名称
     
     - returns: 是否是指定通知 YES / NO
     */
    func isNotification(name:String) -> Bool {
        return self.name == name
    }
}

public extension NSObject
{
    /**
     发送一个指定通知
     
     - parameter name:   通知名称
     - parameter object: 通知内容
     */
    class func postNotification(name:String,withObject object:NSObject?=nil)
    {
        // 保证发送通知在主线程
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName(name, object: object)
        }
    }
    
    /**
     发送一个指定通知
     
     - parameter name:   通知名称
     - parameter object: 通知内容 默认为nil
     */
    func postNotification(name:String,withObject object:NSObject? = nil)
    {
        (self.dynamicType).postNotification(name, withObject: object)
    }
    
    /**
     向当前对象注册一个指定通知
     
     - parameter name: 通知名称
     */
    func registerNotification(name aName:String,selector aSelector: Selector,object anObject: AnyObject? = nil)
    {
        // 确保只注册一次
        unRegisterNotification(aName)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: aSelector, name: aName, object: anObject)
    }
    
    /**
     向当前对象注销一个指定通知
     
     - parameter name: 通知名称
     */
    func unRegisterNotification(name:String)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: name, object: nil)
    }
    
    /**
     注销当前对象上所有已注册的通知
     */
    func unRegisterAllNotification()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}