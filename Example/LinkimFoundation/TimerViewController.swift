//
//  TimerViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/6/30.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var timer:NSTimer?
    
    let label : UILabel = {
        let lab = UILabel()
        lab.text = "1"
        lab.font = UIFont.systemFontOfSize(14)
        lab.textAlignment = .Center
        lab.textColor = UIColor.randomColor()
        return lab
    }()
    
    let startBtn : UIButton = {
        let btn = UIButton(type: .System)
        btn.tag = 1
        btn.setTitle("启动定时器", forState: .Normal)
        btn.backgroundColor = UIColor.colorWithHex8(0xa82020)
        return btn
    }()
    
    let stopBtn : UIButton = {
        let btn = UIButton(type: .System)
        btn.tag = 2
        btn.setTitle("暂停定时器", forState: .Normal)
        btn.backgroundColor = UIColor.colorWithHex6(0xa82020,alpha: 0.5)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(label)
        view.addSubview(startBtn)
        view.addSubview(stopBtn)
        
        label.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.top.equalTo(view.snp_top).offset(100)
            make.height.equalTo(30)
        }
        
        startBtn.snp_makeConstraints { (make) in
            make.top.equalTo(label.snp_bottom).offset(20)
            make.centerX.equalTo(label.snp_centerX)
            make.width.equalTo(view.snp_width).multipliedBy(0.5)
            make.height.equalTo(startBtn.snp_width).multipliedBy(0.2)
        }
        
        stopBtn.snp_makeConstraints { (make) in
            make.top.equalTo(startBtn.snp_bottom).offset(20)
            make.centerX.equalTo(label.snp_centerX)
            make.width.equalTo(view.snp_width).multipliedBy(0.5)
            make.height.equalTo(startBtn.snp_width).multipliedBy(0.2)
        }
        
        startBtn.addTarget(self, action: #selector(onBtnClick(_:)), forControlEvents: .TouchUpInside)
        stopBtn.addTarget(self, action: #selector(onBtnClick(_:)), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        print("viewWillDisappear")
        self.cancelTimer("test name")
        timer = nil
    }
    
    func onBtnClick(sender:UIButton)
    {
        if sender.tag == 1 {
            if timer == nil {
               timer = self.timer(selector: #selector(handleTimer(_:)), timeInterval: 1, repeats: true, name: "test name")
            }else{
                timer?.resumeTimer()
            }
        }else if sender.tag == 2{
            timer?.pauseTimer()
        }
    }
    
    func handleTimer(timer:NSTimer)
    {
        print("\(timer.timeName)")
        label.text = "\(Int(label.text!)!+1)"
    }


    deinit
    {
        print("deinit")
    }
}
