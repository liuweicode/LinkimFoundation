//
//  MainViewController.swift
//  LinkimFoundation
//
//  Created by liuwei on 06/30/2016.
//  Copyright (c) 2016 liuwei. All rights reserved.
//

import UIKit
import LinkimFoundation
import SnapKit

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let rootView: MainView = {
        let rooView = MainView()
        return rooView
    }()

    let vcList = [  "Notification",
                    "Timer",
                    "String",
                    "UIImageView"
                 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        view.addSubview(rootView)
        rootView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vcList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if cell == nil {
           cell = UITableViewCell(style: .Default, reuseIdentifier: "CELL")
        }
        
        cell!.textLabel?.text = vcList[indexPath.row]
        
        return cell!
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0: // Notification
            let controller = NotificationViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        case 1: // Timer
            let controller = TimerViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        case 2: // String
            let controller = StringDemoViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        case 3: // UIImageView
            let controller = UIimageViewViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
}

