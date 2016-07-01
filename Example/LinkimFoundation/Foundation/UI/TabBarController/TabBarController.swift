//
//  TabBarController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/1.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 注册通知
        self.registerNotification(name: Notification_TabBar, selector: #selector(handleNotification(_:)))
        // TODO
        
    }

    func initSubviews()
    {
        
    }
    
    
    func handleNotification(notification:NSNotification)
    {
        
    }
    
    func currentNavigationController() -> UINavigationController? {
        return nil
    }

}
