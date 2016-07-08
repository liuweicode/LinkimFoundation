//
//  ToastView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/8.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import PKHUD

/// 自行扩展
class ToastView: NSObject {
    
    override class func initialize(){
        /*
        PKHUD.sharedHUD.contentView.superview?.superview?.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
        PKHUD.sharedHUD.contentView.superview?.superview?.superview?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
         */
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    }
    
    class func showToast(message:String?)
    {
        HUD.show(.Label(message))
        HUD.hide(afterDelay: 2)
    }
    
    class func showProgressLoading()
    {
        HUD.show(.Progress)
    }
    
    class func showSuccess()
    {
        HUD.show(.Success)
    }
    
    class func hide()
    {
        HUD.hide(animated: true)
    }
    
}
