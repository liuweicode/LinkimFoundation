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

    /**
     16进制转UIColor
     
     - parameter hex8: #RRGGBBAA
     
     - returns: UIColor
     */
    public class func colorWithHex8(hex8:UInt32) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     16进制转UIColor
     
     - parameter hex6:  #RRGGBB
     - parameter alpha: 0.0～1.0
     
     - returns: UIColor
     */
   public class func colorWithHex6(hex6:UInt32, alpha:CGFloat = 1) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
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