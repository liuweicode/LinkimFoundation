//
//  PhoneTextField.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/8.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation

let kPhoneNumLen = 11 //用户手机号长度限制

class PhoneTextField: BaseTextField,UITextFieldDelegate,BaseTextFieldDelegate {

    func initTextData() {
        self.placeholder = "请输入手机号"
        self.keyboardType = .NumberPad
        self.font = UIFont.systemFontOfSize(16)
        self.clearButtonMode = .WhileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        var decimalString = components.joinWithSeparator("") as String
        
        let length = decimalString.length
        
        if length <= 3 {
            textField.text = decimalString
        }else if length > 3 && length <= 7 {
            decimalString.insert(" ", atIndex: decimalString.startIndex.advancedBy(3))
            textField.text = decimalString
        }else if length <= kPhoneNumLen {
            decimalString.insert(" ", atIndex: decimalString.startIndex.advancedBy(3))
            decimalString.insert(" ", atIndex: decimalString.startIndex.advancedBy(8))
            textField.text = decimalString
        }
        self.delegate?.textField!(textField, shouldChangeCharactersInRange: range, replacementString: string)
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.delegate?.textFieldDidEndEditing?(textField)
    }
}
