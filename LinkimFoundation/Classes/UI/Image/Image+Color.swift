//
//  Image+Color.swift
//  Pods
//
//  Created by 刘伟 on 16/7/6.
//
//

import Foundation

public extension UIImage
{

    /**
     根据颜色获取纯色图片
     
     - parameter color: 颜色
     
     - returns: 生成的颜色图片
     */
    public static func imageWithColor(color:UIColor) -> UIImage
    {
        let size = CGSize(width: 20, height: 80)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        color.set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }

}