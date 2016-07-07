//
//  CycleView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

protocol CycleViewDataSource {
    
    func itemCount() -> NSInteger
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)->UICollectionViewCell
    
}

protocol CycleViewDelegate {
    
    func itemDidSelected(indexPath:NSIndexPath)
}

let maxSection:NSInteger = 300
let defaultSection:NSInteger = (maxSection - 1) / 2

class CycleView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    /// 数据源
    var dataSource: CycleViewDataSource?
    
    /// 代理
    var delegate: CycleViewDelegate?
    
    /// 是否自动滚动 默认是
    var isAutoScroll: Bool = true
    
    /// 是否循环播放 默认是
    var isLoop: Bool = true
    
    /// 默认循环时间5s
    var timerInterval: NSTimeInterval = 5
    
    /// 翻页控件
    private var pageView: CyclePageBaseView?
    
    var didSetupConstraints = false
    
    let collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    private var itemCount:NSInteger = 0
    
    init()
    {
        super.init(frame: CGRectZero)
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = self.frame.size
        self.collectionView.contentInset = UIEdgeInsetsZero
        self.collectionView.contentOffset = CGPointZero
        
        self.settingSelectedItemWithRow(0)
        if self.isAutoScroll {
            self.timer(selector: #selector(handleTimer(_:)), timeInterval: timerInterval,repeats: true)
        }
        super.layoutSubviews()
    }
    
    func settingSelectedItemWithRow(indexRow:NSInteger)
    {
        let count = self.dataSource?.itemCount() ?? 0
        if count > 0 && self.isLoop {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexRow,inSection: defaultSection), atScrollPosition: .None, animated: false)
        }
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints {
            
            collectionView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self)
            })
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    func registerClass(cls:AnyClass,identifier:String)
    {
        self.collectionView.registerClass(cls, forCellWithReuseIdentifier: identifier)
    }
    
    func reloadData()
    {
        self.collectionView.reloadData()
    }
    
    func setPageView(pageView:CyclePageBaseView)
    {
        self.pageView?.removeFromSuperview()
        self.pageView = pageView
        self.addSubview(self.pageView!)
    }
    
    func getPageView() -> CyclePageBaseView? {
        return self.pageView
    }
    
    func setItemCount(itemCount:NSInteger)
    {
        self.itemCount = itemCount
        self.pageView?.setPageSize(itemCount)
    }
    
    func handleTimer(timer:NSTimer)
    {
        if self.itemCount == 0 {
            return
        }
        
        let visiablePath = self.collectionView.indexPathsForVisibleItems().first!
        var section = visiablePath.section, row = visiablePath.row
        
        if row == self.itemCount - 1 {
            row = 0
            section = section + 1
        }else{
            row = row + 1
        }
        
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: row,inSection: section), atScrollPosition: .Left, animated: true)
        
        if section == maxSection - 1 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: row,inSection: defaultSection), atScrollPosition: .None, animated: false)
        }
    }
    
    // UICollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.isLoop ? maxSection : 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.itemCount = self.dataSource?.itemCount() ?? 0
        return self.itemCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.dataSource!.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.itemDidSelected(indexPath)
    }
    
    // UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.resetPageIndex()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if self.isAutoScroll {
            self.cancelAllTimers()
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.isAutoScroll {
            self.timer(selector: #selector(handleTimer(_:)), timeInterval: timerInterval,repeats: true)
        }
    }
    
    // 计算当前页
    func resetPageIndex()
    {
        let pageWidth = self.collectionView.frame.size.width
        let page = floor((self.collectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        if let pageSize = self.pageView?.getPagetSize() where pageSize > 0{
            let pageIndex = Int(page % CGFloat(pageSize))
            self.pageView?.setPageIndex(pageIndex)
        }
    }
    
}
