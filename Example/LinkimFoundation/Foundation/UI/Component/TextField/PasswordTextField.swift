//
//  PasswordTextField.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/8.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

let kPasswordMaxLen = 20 // 密码最大长度限制

class PasswordTextField: BaseTextField,UITextFieldDelegate,BaseTextFieldDelegate {

    func initTextData() {
        self.placeholder = "请输入密码"
        self.keyboardType = .Default
        self.font = UIFont.systemFontOfSize(16)
        self.secureTextEntry = true
        self.clearButtonMode = .WhileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        self.delegate?.textField!(textField, shouldChangeCharactersInRange: range, replacementString: string)
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        return newString.length <= kPasswordMaxLen
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.delegate?.textFieldDidEndEditing?(textField)
    }

}
