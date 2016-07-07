//
//  UIScreen+Extension.swift
//  Pods
//
//  Created by Vic on 16/7/5.
//
//

import Foundation

//屏幕宽度
public let ScreenWidth = UIScreen.mainScreen().bounds.width
//屏幕高度
public let ScreenHeight = UIScreen.mainScreen().bounds.height

public enum ScreenSizeType : Int {
    case Screen3_5Inch = 0
    case Screen4Inch
    case Screen4_7Inch
    case Screen5_5Inch
    case UnknownSize
}

extension UIScreen {
    
    /**
     屏幕尺寸类型，仅支持iphone系列
     
     - returns: ScreenSizeType
     */
    public class func sizeType() -> ScreenSizeType {
        switch ScreenHeight {
        case 480:
            return .Screen3_5Inch
        case 568:
            return .Screen4Inch
        case 667:
            return UIScreen.mainScreen().scale == 3.0 ? .Screen5_5Inch : .Screen4_7Inch
        case 736:
            return .Screen5_5Inch
        default:
            return .UnknownSize
        }
    }
    
    static public func isEqualToScreenSize(size: ScreenSizeType) -> Bool {
        return size == UIScreen.sizeType() ? true : false;
    }
    
    static public func isLargerThanScreenSize(size: ScreenSizeType) -> Bool {
        return size.rawValue < UIScreen.sizeType().rawValue ? true : false;
    }
    
    static public func isSmallerThanScreenSize(size: ScreenSizeType) -> Bool {
        return size.rawValue > UIScreen.sizeType().rawValue ? true : false;
    }
}