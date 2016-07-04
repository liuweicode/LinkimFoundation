//
//  Color+Extension.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import Foundation

extension UIColor
{

//    /**
//     16进制转UIColor
//     
//     - parameter hex8: #RRGGBBAA
//     
//     - returns: UIColor
//     */
//    public class func colorWithHex8(hex8:UInt32) -> UIColor {
//        let divisor = CGFloat(255)
//        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
//        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
//        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
//        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
//        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//    /**
//     16进制转UIColor
//     
//     - parameter hex6:  #RRGGBB
//     - parameter alpha: 0.0～1.0
//     
//     - returns: UIColor
//     */
//    public class func colorWithHex6(hex6:UInt32, alpha:CGFloat = 1) -> UIColor {
//        let divisor = CGFloat(255)
//        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
//        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
//        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
//        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//    /**
//     16进制字符串转UIColor
//     
//     - parameter hex: #RRGGBB
//     
//     - returns: UIColor
//     */
//    public class func colorWithHexString(hex:String) -> UIColor
//    {
//        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
//        
//            if (cString.hasPrefix("#"))
//            {
//                let index = cString.startIndex.advancedBy(1)
//                cString = cString.substringFromIndex(index)
//            }
//            
//        if (cString.length != 6)
//        {
//                return UIColor.grayColor()
//        }
//        
//        let index = cString.startIndex.advancedBy(2)
//        
//        var rString = cString.substringToIndex(index)
//        let index2 = index.advancedBy(2)
//        var gString  = cString.substringFromIndex(index2).substringToIndex(index)
//        var bString  = cString.substringFromIndex(index2).substringToIndex(cString.endIndex)
//
//        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
//        NSScanner(string: rString).scanHexInt(&r)
//        NSScanner(string: gString).scanHexInt(&g)
//        NSScanner(string: bString).scanHexInt(&b)
//        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
//    }

    
    /**
     设置透明度
     
     - parameter alpha: 透明值
     
     - returns: UIColor
     */
    func alphaValue(alpha:CGFloat) -> UIColor {
        return self.colorWithAlphaComponent(alpha)
    }
    
    /**
     获取随机色
     
     - returns: UIColor
     */
    public class func randomColor() -> UIColor
    {
        var randomRed:CGFloat   = CGFloat(drand48())

        var randomGreen:CGFloat = CGFloat(drand48())

        var randomBlue:CGFloat  = CGFloat(drand48())

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}