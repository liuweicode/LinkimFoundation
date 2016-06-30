//
//  MainView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/6/30.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class MainView: UIView {

    let tableView:UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    init()
    {
        super.init(frame: CGRectZero)
        addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
