//
//  AdvertView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation

class AdvertView: UIView {

    /// 轮播控件
    var cycleView:CycleView = {
        let cycleView = CycleView()
        cycleView.timerInterval = 3
        cycleView.registerClass(AdvertCollectionViewCell.self, identifier: ADVERT_COLLECTION_CELL_ID)
        return cycleView
    }()
    
    /// 翻页控件
    var pageView:AdvertPageView = {
        let advertPageView = AdvertPageView()
        advertPageView.pageAlignStyle = .Right
        return advertPageView
    }()

    var didSetupConstraints = false
    
    init()
    {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth * 0.5))
        addSubview(cycleView)
        addSubview(pageView)
        cycleView.setPageView(pageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints {
            
            cycleView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self)
            })
            
            pageView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.snp_left)
                make.right.equalTo(self.snp_right)
                make.height.equalTo(10)
                make.bottom.equalTo(self.snp_bottom).offset(-30)
            })
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
}
