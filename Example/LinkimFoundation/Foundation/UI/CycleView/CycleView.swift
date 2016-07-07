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
    
    func cycleView(cycleView:CycleView,indexPath:NSIndexPath)
    
}

class CycleView: UIView {


}
