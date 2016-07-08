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

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CycleViewDataSource,CycleViewDelegate {

    let dataSource: [String] = {
        let dataSource = ["AD_1.jpg","AD_2.jpg"]
        return dataSource
    }()
    
    let rootView: MainView = {
        let rooView = MainView()
        return rooView
    }()

    let vcList = [  "Notification",
                    "Timer",
                    "String",
                    "UIImageView",
                    "AlertView",
                    "Sandbox",
                    "IQKeyboardManagerSwift",
                    "HUD"
                 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.advertView.cycleView.dataSource = self
        rootView.advertView.cycleView.delegate = self
        rootView.advertView.cycleView.getPageView()?.setPageSize(dataSource.count)
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
        case 4: // AlertView
            let controller = AlertViewDemoViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        case 5: // Sandbox
            let controller = SandboxTestViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        case 6: // IQKeyboardManagerSwift test
            let controller = KeyboardManagerTestViewController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        case 7: // HUD
            let controller = HUDViewController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellLineFull(cell)
    }
    
    // CycleViewDataSource
    func itemCount() -> NSInteger {
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ADVERT_COLLECTION_CELL_ID, forIndexPath: indexPath) as! AdvertCollectionViewCell
        cell.setImage(self.dataSource[indexPath.row])
        return cell
    }
    
    // CycleViewDelegate
    func itemDidSelected(indexPath: NSIndexPath) {
        print("itemDidSelected:\(indexPath.section) \(indexPath.row)")
    }
}

