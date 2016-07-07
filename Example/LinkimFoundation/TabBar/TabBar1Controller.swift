//
//  TabBar1ControllerViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/4.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation

class TabBar1Controller: UIViewController {

    let pathBtn:UIButton = {
        let pathBtn = UIButton(type: .System)
        pathBtn.setTitle("path", forState: .Normal)
        return pathBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        view.addSubview(pathBtn)
        
        kScreenWidth
        if UIScreen.sizeType() == .Size_3_5
        {
        
        }
        
        pathBtn.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_top).offset(100)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        pathBtn.addTarget(self, action: #selector(pathTest(_:)), forControlEvents: .TouchUpInside)
    }
    
    func pathTest(sender:UIButton)
    {
        let controller = SandboxTestViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }

}
