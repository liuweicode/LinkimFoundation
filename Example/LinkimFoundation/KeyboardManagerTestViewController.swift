//
//  KeyboardManagerTestViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class KeyboardManagerTestViewController: UIViewController, UITextFieldDelegate {

    let textField1: PhoneTextField = {
        let textField = PhoneTextField()
        textField.borderStyle = .RoundedRect
        return textField
    }()
    let textField2: PasswordTextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .RoundedRect
        return textField
    }()
    
    let placeholderTextView: PlaceholderTextView = {
        let placeholderTextView = PlaceholderTextView()
        placeholderTextView.placeholder = "测试测试placeholder"
        placeholderTextView.placeholderColor = UIColor.darkGrayColor()
        placeholderTextView.font = UIFont.systemFontOfSize(18)
        placeholderTextView.layer.borderColor = UIColor.blackColor().CGColor
        placeholderTextView.layer.borderWidth = 1
        return placeholderTextView
    }()
    
    
    /* !!!!!!!!!!!!!
     需要在AppDelegate的didFinishLaunchingWithOptions方法中设置：
     IQKeyboardManager.sharedManager().enable = true
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        textField1.delegate = self
        textField2.delegate = self
        
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(placeholderTextView)
        
        textField1.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.snp_top).offset(100)
            make.height.equalTo(40)
        }
        
        textField2.snp_makeConstraints { (make) in
            make.top.equalTo(textField1.snp_bottom).offset(10)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }
        
        placeholderTextView.snp_makeConstraints { (make) in
            make.top.equalTo(textField2.snp_bottom).offset(10)
            make.left.right.equalTo(self.view).inset(10)
            make.height.equalTo(100)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("======")
        return true
    }

}
