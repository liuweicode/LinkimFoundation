//
//  TableView+Extension.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

extension UITableView
{
    /**
     取消多余的分割线
     */
    func cellLineHidden()
    {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        self.tableFooterView = view
    }
    
    /**
     分割线充满
     
     - parameter cell: 当前Cell
     */
    func cellLineFull(cell:UITableViewCell)
    {
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
}