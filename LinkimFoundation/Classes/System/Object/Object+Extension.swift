//
//  Object+Extention.swift
//  Pods
//
//  Created by 刘伟 on 16/7/4.
//
//

import Foundation

public extension NSObject {
    
    public class func fromClassName(className : String) -> NSObject {
        let className = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String + "." + className
        let aClass = NSClassFromString(className) as! UIViewController.Type
        return aClass.init()
    }
    
}