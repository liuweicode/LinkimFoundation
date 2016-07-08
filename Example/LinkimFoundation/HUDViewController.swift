//
//  HUDViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/8.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class HUDViewController: UIViewController {

    let showToastBtn:UIButton = {
        let showToastBtn = UIButton(type: .System)
        showToastBtn.setTitle("show toast", forState: .Normal)
        return showToastBtn
    }()
    
    let showLoadingBtn:UIButton = {
        let showLoadingBtn = UIButton(type: .System)
        showLoadingBtn.setTitle("show loading", forState: .Normal)
        return showLoadingBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(showToastBtn)
        view.addSubview(showLoadingBtn)
        
        showToastBtn.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_top).offset(180)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        showLoadingBtn.snp_makeConstraints { (make) in
            make.top.equalTo(showToastBtn.snp_bottom).offset(20)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        showToastBtn.addTarget(self, action: #selector(showToast(_:)), forControlEvents: .TouchUpInside)
        showLoadingBtn.addTarget(self, action: #selector(showLoading(_:)), forControlEvents: .TouchUpInside)
    }

    func showToast(sender:UIButton)
    {
        ToastView.showToast("报错了报错了报错了报错了报错了")
    }
    
    func showLoading(sender:UIButton)
    {
       ToastView.showProgressLoading()
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            NSThread.sleepForTimeInterval(4)
            dispatch_async(dispatch_get_main_queue(), { 
                ToastView.hide()
            })
        }
    }
}
