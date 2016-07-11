//
//  SMSCaptchaTextField.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/11.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation

let kCaptchaLen = 6 // 验证码长度

class SMSCaptchaTextField: BaseTextField,UITextFieldDelegate,BaseTextFieldDelegate {

    var obtainButton:UIButton = {
        let obtainButton = UIButton(type: .Custom)
        obtainButton.setTitle("获取验证码", forState: .Normal)
        obtainButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        obtainButton.setTitleColor(UIColor.lightGrayColor(), forState: .Disabled)
        return obtainButton
    }()
    
    func initTextData() {
        self.placeholder = "请输入短信验证码"
        self.keyboardType = .NumberPad
        self.font = UIFont.systemFontOfSize(16)
        self.clearButtonMode = .WhileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.delegate?.textField!(textField, shouldChangeCharactersInRange: range, replacementString: string)
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        return newString.length <= kCaptchaLen
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.delegate?.textFieldDidEndEditing?(textField)
    }

}
