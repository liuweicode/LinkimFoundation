//
//  AlertViewDemoViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class AlertViewDemoViewController: UIViewController {

    let normalBtn:UIButton = {
        let normalBtn = UIButton(type: .System)
        normalBtn.setTitle("show normal dialog", forState: .Normal)
        return normalBtn
    }()
    
    let customerBtn:UIButton = {
        let customerBtn = UIButton(type: .System)
        customerBtn.setTitle("show customer dialog", forState: .Normal)
        return customerBtn
    }()
    
    var tf:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(normalBtn)
        view.addSubview(customerBtn)
        
        normalBtn.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_top).offset(180)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        customerBtn.snp_makeConstraints { (make) in
            make.top.equalTo(normalBtn.snp_bottom).offset(20)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        normalBtn.addTarget(self, action: #selector(showNormalDialog(_:)), forControlEvents: .TouchUpInside)
        customerBtn.addTarget(self, action: #selector(showCustomerDialog(_:)), forControlEvents: .TouchUpInside)
        
    }

    func showNormalDialog(sender:UIButton)
    {
        let cancelBtn = AlertViewButtonItem(inLabel: "取消")
        
        let okBtn = AlertViewButtonItem(inLabel: "确定") {
            print("确定")
        }
        let alertView = AlertView(title: "提示", message: "测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容", cancelButtonItem: cancelBtn, otherButtonItems: okBtn)
        alertView.show()
    }

    func showCustomerDialog(sender:UIButton)
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width * 0.9, height: 320))
        view.backgroundColor = UIColor.redColor()
        tf = UITextField()
        view.addSubview(tf!)
        tf!.borderStyle = .RoundedRect;
        tf!.snp_makeConstraints { (make) in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(40)
        }
        
        let btn = UIButton(type: .Custom)
        btn.setTitle("确定", forState: .Normal)
        view.addSubview(btn)
        
        btn.snp_makeConstraints { (make) in
            make.top.equalTo(tf!.snp_bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        btn.addTarget(self, action: #selector(test(_:)), forControlEvents: .TouchUpInside)
        
        let cancelBtn = AlertViewButtonItem(inLabel: "取消"){
            print("取消")
        }
        
        let okBtn = AlertViewButtonItem(inLabel: "确定") {
            print("确定")
        }
        let alertView = AlertView()
        alertView.containerView.addSubview(view)
        alertView.setCancelButtonItem(cancelBtn)
        alertView.setOtherButtonItems(okBtn)
        alertView.show()
    }
    
    func test(sender:UIButton)
    {
        tf?.resignFirstResponder()
    }
}
