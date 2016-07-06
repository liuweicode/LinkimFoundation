//
//  TabBarController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/1.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation

class TabBarController: UITabBarController {

    var tabBarDataSource:TabBarDataSource? // tabbar数据源
    
    var tabBarView:TabBarView? // 自定义的TabBar
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 注册tabbar点击事件
        self.registerNotification(name: Notification_TabBar, selector: #selector(handleNotification(_:)))
        
        // 加载子界面
        self.initSubviews()
        
        // 移除系统生成的baritem
        self.removeSystemBarItem()
        
        // 加载自定义Tabbar
        self.initCustomTabbarView()
        
    }

    
    /**
     防止系统tabbar按钮显示
     */
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.removeSystemBarItem()
    }
    
    /**
     防止系统tabbar按钮显示
     */
    override func viewWillAppear(animated: Bool) {
        self.removeSystemBarItem()
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initSubviews()
    {
        self.tabBarDataSource = TabBarConfig.sharedInstance.dataSource
        if tabBarDataSource != nil
        {
            var controllers = [UIViewController]()
            for item in tabBarDataSource!.items {
                if let controller:UIViewController = NSObject.fromClassName(item.className) as? UIViewController
                {
                    controller.title = item.title
                    let navigationController = UINavigationController(rootViewController: controller)
                    controllers.append(navigationController)
                }
            }
            self.viewControllers = controllers
        }
    }
    
    func removeSystemBarItem()
    {
        for systemTabbarItem in self.tabBar.subviews {
            if !systemTabbarItem.isKindOfClass(TabBarView) {
                systemTabbarItem.removeFromSuperview()
            }
        }
    }
    
    func initCustomTabbarView()
    {
        self.tabBarView = TabBarView(self.tabBarDataSource!.items)
        self.tabBarView!.topLineColor = UIColor(rgba: self.tabBarDataSource!.shadowColor, defaultColor: UIColor.redColor())
        self.tabBarView!.backgroundColor = UIColor(rgba: self.tabBarDataSource!.backgroundColor, defaultColor: UIColor.greenColor())
        self.tabBar.addSubview(self.tabBarView!)
        self.tabBarView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self.tabBar)
        })
    }
    
    func handleNotification(notification:NSNotification)
    {
        if notification.isNotification(Notification_TabBar) {
            let tabBarNotify = notification.object as! TabBarNotification
            self.selectedIndex = tabBarNotify.index
        }
    }
    
    func currentNavigationController() -> UIViewController? {
        if self.viewControllers?.count == 0 {
            return nil
        }
        return self.selectedViewController
    }

    deinit
    {
        self.unRegisterAllNotification()
    }
}
