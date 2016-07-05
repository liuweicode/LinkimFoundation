//
//  UIScreen+Extension.swift
//  Pods
//
//  Created by Vic on 16/7/5.
//
//

import Foundation

//常量
public let kScreenWidth = UIScreen.mainScreen().bounds.width
public let kScreenHeight = UIScreen.mainScreen().bounds.height

public enum ScreenSizeType : Int {
    case Size_3_5
    case Size_4_0
    case Size_4_7
    case Size_5_5
}

extension UIScreen {
    
    public class func sizeType() -> ScreenSizeType {
        switch kScreenHeight {
        case 480:
            return .Size_3_5
        case 568:
            return .Size_4_0
        case 667:
            return .Size_4_7
        case 736:
            return .Size_5_5
        default:
            return .Size_5_5
        }
    }
}