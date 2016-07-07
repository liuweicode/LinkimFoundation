//
//  CyclePageBaseView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

// 翻页点的对齐方式
enum CyclePageAlignStyle:Int {
    case Left,Center,Right
}

class CyclePageBaseView: UIView {

    /// 页数
    private var pageSize: NSInteger = 0
    
    /// 当前第几页
    private var pageIndex: NSInteger = 0
    
    /// 未选中状态圆点
    var normalImageName: String?
    
    /// 选中状态圆点
    var pressedImageName: String?
    
    /// 圆点间距
    var dotMargin: CGFloat = 0
    
    /// 圆点长度
    var dotWidth: CGFloat = 0
    
    /// 翻页远点的对齐方式
    var pageAlignStyle:CyclePageAlignStyle = .Center // 默认居中对齐

    let contentView:UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.clearColor()
        return contentView
    }()
    
    var didSetupConstraints = false
    
    init(){
        super.init(frame: CGRectZero)
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPagetSize() -> NSInteger
    {
        return self.pageSize
    }
    
    func setPageSize(pageSize:NSInteger)
    {
        self.pageSize = pageSize
        self.contentView.subviews.enumerate().forEach { (index,view) in
            view.removeFromSuperview()
        }
        
        for i in 0..<self.pageSize {
            let imageView = UIImageView()
            imageView.tag = i + 1
            self.contentView.addSubview(imageView)
        }
        setPageIndex(0)
        self.didSetupConstraints = false
        self.setNeedsUpdateConstraints()
    }
    
    func setPageIndex(pageIndex:NSInteger)
    {
        if pageIndex == self.pageIndex && pageIndex != 0 {
            return
        }
        
        self.pageIndex = pageIndex
        for i in 0..<self.pageSize {
            let imageView = self.contentView.viewWithTag(i+1) as! UIImageView
            if pageIndex == i {
                    imageView.image = UIImage(named: self.pressedImageName!)
            }else{
                    imageView.image = UIImage(named: self.normalImageName!)
            }
        }
    }
    
    func updateConstraintsForLeft() {
        var previousView:UIView? = nil
        self.contentView.subviews.enumerate().forEach { (index,view) in
            view.snp_makeConstraints(closure: { (make) in
                if let pre = previousView
                {
                    make.left.equalTo(pre.snp_right).offset(dotMargin)
                }else{
                    make.left.equalTo(self.contentView.snp_left).offset(dotMargin)
                }
                make.top.bottom.equalTo(self.contentView)
                make.width.equalTo(dotWidth)
            })
            previousView = view
        }
        
        if let pre = previousView {
            contentView.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(self)
                make.left.equalTo(self.snp_left).offset(20)
                make.right.equalTo(pre.snp_right)
            })
        }
    }
    
    func updateConstraintsForRight() {
        var previousView:UIView? = nil
        self.contentView.subviews.reverse().enumerate().forEach { (index,view) in
            view.snp_makeConstraints(closure: { (make) in
                if let pre = previousView
                {
                    make.right.equalTo(pre.snp_left).offset(-dotMargin)
                }else{
                    make.right.equalTo(self.contentView.snp_right).offset(-dotMargin)
                }
                make.top.bottom.equalTo(self.contentView)
                make.width.equalTo(dotWidth)
            })
            previousView = view
        }
        
        if let pre = previousView {
            contentView.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(self)
                make.left.equalTo(pre.snp_left)
                make.right.equalTo(self.snp_right).offset(-20)
            })
        }
    }
    
    func updateConstraintsForCenter() {
        var previousView:UIView? = nil
        self.contentView.subviews.enumerate().forEach { (index,view) in
            view.snp_makeConstraints(closure: { (make) in
                if let pre = previousView
                {
                    make.left.equalTo(pre.snp_right).offset(dotMargin)
                }else{
                    make.left.equalTo(self.contentView.snp_left).offset(dotMargin)
                }
                make.top.bottom.equalTo(self.contentView)
                make.width.equalTo(dotWidth)
            })
            previousView = view
        }
        
        if let pre = previousView {
            contentView.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(self)
                make.left.equalTo(self.contentView.subviews.first!.snp_left).priorityLow()
                make.right.equalTo(pre.snp_right).priorityLow()
                make.centerX.equalTo(self.snp_centerX)
            })
        }
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints
        {
            switch self.pageAlignStyle {
            case .Left:
                self.updateConstraintsForLeft()
            case .Center:
                self.updateConstraintsForCenter()
            case .Right: 
                self.updateConstraintsForRight()
            }
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
}
