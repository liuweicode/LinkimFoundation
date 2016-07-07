//
//  AdvertPageView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class AdvertPageView: CyclePageBaseView {

    override init() {
        super.init()
        self.dotMargin = 7
        self.dotWidth = 10
        self.normalImageName = "guide_page_normal"
        self.pressedImageName = "guide_page_pressed"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
