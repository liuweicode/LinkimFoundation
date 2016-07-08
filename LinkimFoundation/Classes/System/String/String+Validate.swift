//
//  String+Validate.swift
//  Pods
//
//  Created by 刘伟 on 16/7/1.
//
//

import Foundation

public extension String
{

    /**
     是否是有效的手机号
     
     - returns: true / false
     */
    public func isMobile() -> Bool {
        
        let MOBILE = "^1(3[0-9]|5[0-9]|8[0-9]|4[0-9]|7[0-9])\\d{8}$"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",MOBILE)
        
        return regextestmobile.evaluateWithObject(self)
    }

    /**
     是否是有效的身份证
     
     - returns: true / false
     */
    public func isIDCard() -> Bool {
        
        let MOBILE = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",MOBILE)
        
        return regextestmobile.evaluateWithObject(self)
    }

    /**
     是否是空字符串
     比如 "  " -> true
         " 1 " -> false
     
     - returns: true / false
     */
    public func isBlank() -> Bool {
        let trimmed = self.trim()
        return trimmed.isEmpty
    }
    
    public func isPureInt() -> Bool {
        if self.length > 0 {
            let scan = NSScanner(string: self)
            var val:CInt = 0
            return scan.scanInt(&val) && scan.atEnd
        }
        return false
    }
}