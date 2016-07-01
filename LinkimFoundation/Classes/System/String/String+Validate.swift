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
    func isMobile() -> Bool {
        
        let MOBILE = "^1(3[0-9]|5[0-9]|8[0-9]|4[0-9]|7[0-9])\\d{8}$"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",MOBILE)
        
        return regextestmobile.evaluateWithObject(self)
    }

    /**
     是否是有效的身份证
     
     - returns: true / false
     */
    func isIDCard() -> Bool {
        
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
    func isBlank() -> Bool {
        let trimmed = self.trim()
        return trimmed.isEmpty
    }
    
}