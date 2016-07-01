//
//  TabBarItemView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/1.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class TabBarItemView: UIView {

    // 是否选中
    var selectStatus:Bool{
        get {
            return self.selectStatus
        }
        set{
            self.selectStatus = newValue
            let imageName = self.selectStatus ? self.item.highlightedImageName : self.item.normalImageName
            self.imageView.image = UIImage(named: imageName)
        }
    }
    
    var item : TabBarItem
    
    // 图片
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    
    // 按钮
    var button: UIButton = {
        let button = UIButton(type: .Custom)
        return button
    }()
    
    // 新消息提示
    var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(12)
        label.backgroundColor = UIColor.redColor()
        label.layer.masksToBounds = true
        return label
    }()
    
    var didSetupConstraints = false
    
    init(_ aItem: TabBarItem)
    {
        item = aItem
        super.init(frame: CGRectZero)
        imageView.image = UIImage(named: item.normalImageName)
        addSubview(imageView)
        
        button.addTarget(self, action: #selector(buttonClicked(_:)), forControlEvents: .TouchUpInside)
        addSubview(button)
        
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints {
            
            imageView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.snp_top)
                make.bottom.equalTo(self.snp_bottom)
                make.width.equalTo(imageView.snp_height)
                make.centerX.equalTo(self.snp_centerX)
            })
            
            button.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self)
            })
            
            label.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(imageView.snp_right)
                make.top.equalTo(self.snp_top)
                make.width.height.greaterThanOrEqualTo(6)
            })
            
            didSetupConstraints = true
        }
    }
    
    func buttonClicked(sender:UIButton)
    {
        if self.selectStatus {
            return
        }
        
        let tabBarNotification = TabBarNotification()
        tabBarNotification.index = self.tag - 1
        self.postNotification(Notification_TabBar, withObject: tabBarNotification)
    }
    
}
