//
//  String+Utils.swift
//  Pods
//
//  Created by 刘伟 on 16/7/1.
//
//

import Foundation

public extension String
{
    // 字符串长度
    var length:Int{
        get {
            return self.characters.count
        }
    }
    
    // 转OC字符串
    var OCString: NSString {
        get {
            return self as NSString
        }
    }
    
    /**
     trim 去除两端空格
     
     - returns: eg. " 1 2 " -> "1 2"
     */
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    /**
     如果String是nil，则返回空字符串
     
     - parameter optionalString: 可选的String
     
     - returns: 安全的字符串
     */
    static func safeString(optionalString:String?) -> String {
        return optionalString ?? ""
    }
    
    static func phoneFormat(sourceS:String) -> String{
        if sourceS.length > 0 {
            var tmpS = sourceS
            for i in 3.stride(to: sourceS.length, by: 5) {
                tmpS.insert(" ", atIndex: sourceS.startIndex.advancedBy(i))
            }
            return tmpS
        }
        return sourceS
    }
    
}