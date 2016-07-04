//
//  TabBarView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/1.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class TabBarView: UIView {

    var topLineColor: UIColor?
    
    var items:[TabBarItem]
    
    var didSetupConstraints = false
    
    init(_ frame:CGRect , _ aItems:[TabBarItem])
    {
        items = aItems
        super.init(frame: frame)
        self.registerNotification(name: Notification_TabBar, selector: #selector(handleNotification(_:)))
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews()
    {
        for index in 0..<self.items.count {
            let tabBarItem = self.items[index]
            let tabBarItemView = TabBarItemView(tabBarItem)
            tabBarItemView.tag = (index + 1)
            self.addSubview(tabBarItemView)
            if index == 0 {
                tabBarItemView.selectStatus = true
            }
        }
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints {
            
            let preTabBarItemView:TabBarItemView? = nil
            
            let width = UIScreen.mainScreen().bounds.width / CGFloat(self.items.count)
            
            for index in 0...self.items.count {
                
                let tabBarItemView = self.viewWithTag((index + 1)) as! TabBarItemView
                    
                tabBarItemView.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(self.snp_top)
                    make.bottom.equalTo(self.snp_bottom)
                    make.width.equalTo(width)
                    if preTabBarItemView == nil
                    {
                        make.left.equalTo(self.snp_left)
                    }else{
                        make.left.equalTo(preTabBarItemView!.snp_right)
                    }
                })
            }
            didSetupConstraints = true
        }
    }

    func handleNotification(notification:NSNotification)
    {
        
    }
}
