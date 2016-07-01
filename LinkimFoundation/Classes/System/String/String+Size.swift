//
//  String+Size.swift
//  Pods
//
//  Created by 刘伟 on 16/7/1.
//
//

import Foundation

public extension String
{
    /**
     计算字符串大小
     
     - parameter font:    字体
     - parameter maxSize: 最大size
     
     - returns: 字符串大小
     */
    func sizeWithFont(font font:UIFont,maxSize:CGSize) -> CGSize {
        if self.isEmpty {
            return CGSizeZero
        }
        return self.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
    }
    
}