//
//  AlertView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/6.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class AlertViewButtonItem: NSObject {
    var label:String
    var action:(()->Void)?
    init(inLabel:String) {
        label = inLabel
    }
    init(inLabel:String,inAction:()->Void) {
        label = inLabel
        action = inAction
    }
}

enum AlertViewStyle:Int {
    case Normal,Customer
}

typealias AlertViewButtonTouchUpInside = (alertView:AlertView, buttonIndex:Int) -> Void

let Alert_View_Corner_Radius:CGFloat = 7

class AlertView: UIView {

    var parentView:UIView?
    
    private var alertViewStyle:AlertViewStyle
    
    var didSetupConstraints = false
    
    var dialogView:UIView = {
        let dialogView = UIView()
        dialogView.backgroundColor = UIColor.whiteColor()
        dialogView.layer.cornerRadius = Alert_View_Corner_Radius;
        dialogView.layer.masksToBounds = true
        dialogView.layer.borderColor = UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0).CGColor
        dialogView.layer.borderWidth = 0.65;
        dialogView.layer.shadowRadius = Alert_View_Corner_Radius + 5;
        dialogView.layer.shadowOpacity = 0.1;
        dialogView.layer.shadowOffset = CGSizeMake(0 - (Alert_View_Corner_Radius+5)/2, 0 - (Alert_View_Corner_Radius+5)/2);
        dialogView.layer.shadowColor = UIColor.blackColor().CGColor;
        dialogView.layer.shadowPath = UIBezierPath(roundedRect: dialogView.bounds, cornerRadius: dialogView.layer.cornerRadius).CGPath
        return dialogView
    }()
    
    var containerView:UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.whiteColor()
        return containerView
    }()
    
    private var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        return lineView
    }()
    
    var buttonContainerView:UIView = {
        let buttonContainerView = UIView()
        buttonContainerView.backgroundColor = UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        return buttonContainerView
    }()
    
    lazy var titleLable:UILabel = {
        let titleLable = UILabel()
        titleLable.backgroundColor = UIColor.whiteColor()
        titleLable.numberOfLines = 0
        titleLable.textAlignment = .Center
        titleLable.font = UIFont.boldSystemFontOfSize(16)
        titleLable.textColor = UIColor(hex6: 0x858585)
        return titleLable
    }()
    
    lazy var messageLabel:UILabel = {
        let messageLabel = UILabel()
        messageLabel.backgroundColor = UIColor.whiteColor()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .Center
        messageLabel.font = UIFont.systemFontOfSize(13)
        messageLabel.textColor = UIColor(hex6: 0x858585)
        return messageLabel
    }()
    
    private var cancelButtonItem:AlertViewButtonItem?
    private var otherButtonItems:[AlertViewButtonItem]?
    
    var onButtonTouchUpInside:AlertViewButtonTouchUpInside?
    
    func setCancelButtonItem(cancelButtonItem:AlertViewButtonItem)
    {
        self.cancelButtonItem = cancelButtonItem
        buttonContainerView.subviews.enumerate().forEach { (index,view) in
            view.removeFromSuperview()
        }
        self.setButtons()
    }
    
    func setOtherButtonItems(otherButtonItems:AlertViewButtonItem...)
    {
        self.otherButtonItems = otherButtonItems
        buttonContainerView.subviews.enumerate().forEach { (index,view) in
            view.removeFromSuperview()
        }
        self.setButtons()
    }
    
    func setButtons()
    {
        var buttonsArray = otherButtonItems ?? [AlertViewButtonItem]()
        if let inCancelButtonItem = cancelButtonItem {
            buttonsArray.insert(inCancelButtonItem, atIndex: 0)
        }
        for (index,value) in buttonsArray.enumerate() {
            let closeButton = UIButton(type: .Custom)
            closeButton.tag = index
            closeButton.setTitle(value.label, forState: .Normal)
            closeButton.setTitleColor(UIColor(hex6: 0x858585), forState: .Normal)
            closeButton.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
            closeButton.layer.cornerRadius = Alert_View_Corner_Radius
            closeButton.setBackgroundImage(UIImage.imageWithColor(UIColor(hex6: 0x00f7f8f9)), forState: .Normal)
            closeButton.setBackgroundImage(UIImage.imageWithColor(UIColor(hex6: 0x00f7f8f9).alphaValue(0.8)), forState: .Highlighted)
            closeButton.addTarget(self, action: #selector(onButtonClick(_:)), forControlEvents: .TouchUpInside)
            buttonContainerView.addSubview(closeButton)
        }
    }
    
    init() {
        alertViewStyle = .Customer
        super.init(frame: CGRectZero)
        let screenBounds = UIScreen.mainScreen().bounds
        frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)

        dialogView.addSubview(containerView)
        dialogView.addSubview(lineView)
        dialogView.addSubview(buttonContainerView)
        addSubview(dialogView)
        
        self.registerNotification(name: UIKeyboardWillShowNotification, selector: #selector(keyboardWillShow(_:)))
        self.registerNotification(name: UIKeyboardWillHideNotification, selector: #selector(keyboardWillHide(_:)))
    }
    
    convenience init(title inTitle:String?,message inMessage:String?,cancelButtonItem inCancelButtonItem:AlertViewButtonItem?,otherButtonItems inOtherButtonItems:AlertViewButtonItem...) {
        self.init()
        
        alertViewStyle = .Normal
        cancelButtonItem = inCancelButtonItem
        otherButtonItems = inOtherButtonItems
        
        titleLable.text = inTitle
        messageLabel.text = inMessage
        
        containerView.addSubview(titleLable)
        containerView.addSubview(messageLabel)
        
        self.setButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onButtonClick(sender:UIButton)
    {
        let tag = sender.tag
        if tag == 0 {
            if let inCancelButtonItem = cancelButtonItem {
                inCancelButtonItem.action?()
            }else{
                otherButtonItems![0].action?()
            }
        }else{
            if let _ = cancelButtonItem {
                otherButtonItems![tag-1].action?()
            }else{
                otherButtonItems![tag].action?()
            }
        }
       self.close()
    }
    
    private func updateNormalConstraint()
    {
        let screenSize = UIScreen.mainScreen().bounds
        let dialogViewWidth = screenSize.width * CGFloat(0.75)
        
        dialogView.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY).offset(-20)
            make.width.equalTo(dialogViewWidth)
            make.height.greaterThanOrEqualTo(0).priorityLow()
        })
        
        containerView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(dialogView.snp_left)
            make.top.equalTo(dialogView.snp_top)
            make.right.equalTo(dialogView.snp_right)
            make.height.greaterThanOrEqualTo(0).priorityLow()
        })
        
        titleLable.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(containerView.snp_top).offset(titleLable.text == nil ? 0 : 10)
            make.centerX.equalTo(containerView.snp_centerX)
            make.left.equalTo(containerView.snp_left).offset(10)
            make.right.equalTo(containerView.snp_right).offset(-10)
            make.height.greaterThanOrEqualTo(0)
        })
        
        messageLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(titleLable.snp_bottom).offset(messageLabel.text == nil ? 0 : 10)
            make.centerX.equalTo(containerView.snp_centerX)
            make.left.equalTo(containerView.snp_left).offset(10)
            make.right.equalTo(containerView.snp_right).offset(-10)
            make.height.greaterThanOrEqualTo(0)
        })
        
        containerView.snp_updateConstraints(closure: { (make) in
            make.bottom.equalTo(messageLabel.snp_bottom).offset(10)
        })
        
        lineView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(dialogView.snp_left)
            make.top.equalTo(containerView.snp_bottom)
            make.right.equalTo(dialogView.snp_right)
            make.height.equalTo(1)
        })
        
        buttonContainerView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(dialogView.snp_left)
            make.top.equalTo(lineView.snp_bottom)
            make.right.equalTo(dialogView.snp_right)
            make.height.equalTo(40)
        })
        
        buttonContainerView.subviews.enumerate().forEach({ (index,view) in
            let button = view as! UIButton
            button.snp_makeConstraints(closure: { (make) in
                if index == 0 {
                    make.left.equalTo(buttonContainerView.snp_left)
                } else {
                    let previousButton = buttonContainerView.subviews[index - 1]
                    make.left.equalTo(previousButton.snp_right).offset(1)
                    if index == buttonContainerView.subviews.count - 1 {
                        make.right.equalTo(buttonContainerView.snp_right)
                    }
                }
                make.top.bottom.height.equalTo(buttonContainerView)
                make.width.equalTo(buttonContainerView.snp_width).dividedBy(buttonContainerView.subviews.count).priorityLow()
            })
            
        })
        
        dialogView.snp_updateConstraints(closure: { (make) in
            make.bottom.equalTo(buttonContainerView.snp_bottom)
        })
    }
    
    func updateCustomerConstraint()
    {
        let lastView = containerView.subviews.last!
        let size = lastView.frame.size
        
        dialogView.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY).offset(-20)
            make.width.equalTo(size.width)
            make.height.greaterThanOrEqualTo(0).priorityLow()
        })
        
        containerView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(dialogView.snp_left)
            make.top.equalTo(dialogView.snp_top)
            make.right.equalTo(dialogView.snp_right)
            make.bottom.equalTo(lastView.snp_bottom)
        })
        
        lineView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(dialogView.snp_left)
            make.top.equalTo(containerView.snp_bottom)
            make.right.equalTo(dialogView.snp_right)
            make.height.equalTo(1)
        })
        
        buttonContainerView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(dialogView.snp_left)
            make.top.equalTo(lineView.snp_bottom)
            make.right.equalTo(dialogView.snp_right)
            make.height.equalTo(40)
        })
        
        buttonContainerView.subviews.enumerate().forEach({ (index,view) in
            let button = view as! UIButton
            button.snp_makeConstraints(closure: { (make) in
                if index == 0 {
                    make.left.equalTo(buttonContainerView.snp_left)
                } else {
                    let previousButton = buttonContainerView.subviews[index - 1]
                    make.left.equalTo(previousButton.snp_right).offset(1)
                    if index == buttonContainerView.subviews.count - 1 {
                        make.right.equalTo(buttonContainerView.snp_right)
                    }
                }
                make.top.bottom.height.equalTo(buttonContainerView)
                make.width.equalTo(buttonContainerView.snp_width).dividedBy(buttonContainerView.subviews.count).priorityLow()
            })
            
        })
        
        dialogView.snp_updateConstraints(closure: { (make) in
            make.bottom.equalTo(buttonContainerView.snp_bottom)
        })
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints {
        
            switch alertViewStyle {
            case .Normal:
                self.updateNormalConstraint()
            case .Customer:
                self.updateCustomerConstraint()
            }
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    // Keyboard Notification
    func keyboardWillShow(notification:NSNotification)
    {
        let keyboardSize = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        let bottomHeight = (UIScreen.mainScreen().bounds.height - CGRectGetMaxY(dialogView.frame))
        if bottomHeight < keyboardSize.height {
            let dialogSize = dialogView.frame.size
            dialogView.snp_remakeConstraints(closure: { (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.width.equalTo(dialogSize.width)
                make.height.equalTo(dialogSize.height)
                make.bottom.equalTo(self.snp_bottom).offset(-(keyboardSize.height + 20))
            })
            self.setNeedsLayout()
            UIView.animateWithDuration(0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification)
    {
        let dialogSize = dialogView.frame.size
        dialogView.snp_remakeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(-20)
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(dialogSize.width)
            make.height.equalTo(dialogSize.height)
        })
        self.setNeedsLayout()
        UIView.animateWithDuration(0.2) {
            self.layoutIfNeeded()
        }
    }
    
    /**
     显示Dialog
     */
    func show()
    {
        if let inParentView  = parentView{
            inParentView.addSubview(self)
            self.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(inParentView)
            })
        }else{
            let frontToBackWindows = UIApplication.sharedApplication().windows.reverse()
            for window in frontToBackWindows {
                let windowOnMainScreen = window.screen == UIScreen.mainScreen()
                let windowIsVisible = (!window.hidden) && window.alpha > 0
                let windowLevelNormal = window.windowLevel == UIWindowLevelNormal
                
                if windowOnMainScreen && windowIsVisible && windowLevelNormal {
                    window.addSubview(self)
                    self.snp_makeConstraints(closure: { (make) in
                        make.edges.equalTo(window)
                    })
                    break
                }
            }
        }

        dialogView.layer.opacity = 0.5;
        dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.0)
        
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseInOut, animations: {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.dialogView.layer.opacity = 1
            self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: nil)
 
    }

    /**
     关闭Dialog
     */
    func close()
    {
        dialogView.layer.opacity = 1
        let currentTransform = dialogView.layer.transform
        UIView.animateWithDuration(0.2, delay: 0, options: .TransitionNone, animations: { 
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1.0))
            self.dialogView.layer.opacity = 0.0
            }) { (finished) in
                 self.subviews.enumerate().forEach({ (index,view) in
                    view.removeFromSuperview()
                 })
                self.removeFromSuperview()
        }
    }

}
