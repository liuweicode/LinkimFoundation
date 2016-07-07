//
//  KeyboardManagerTestViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class KeyboardManagerTestViewController: UIViewController {

    let textField1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .RoundedRect
        textField.placeholder = "请输入1..."
        return textField
    }()
    let textField2: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .RoundedRect
        textField.placeholder = "请输入2..."
        return textField
    }()
    
    /* !!!!!!!!!!!!!
     需要在AppDelegate的didFinishLaunchingWithOptions方法中设置：
     IQKeyboardManager.sharedManager().enable = true
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(textField1)
        view.addSubview(textField2)
        
        textField1.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-100)
            make.height.equalTo(40)
        }
        
        textField2.snp_makeConstraints { (make) in
            make.top.equalTo(textField1.snp_bottom).offset(10)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }
        
    }

}
