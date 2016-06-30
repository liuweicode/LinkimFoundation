//
//  NotificationViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/6/30.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        registerNotification(name: "viewDidLoad", selector: #selector(testNotification(_:)))
        registerNotification(name: "viewWillAppear", selector: #selector(testNotification(_:)))
        registerNotification(name: "viewDidAppear", selector: #selector(testNotification(_:)))
        registerNotification(name: "viewWillDisappear", selector: #selector(testNotification(_:)))
        registerNotification(name: "viewDidDisappear", selector: #selector(testNotification(_:)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        print("-->viewDidLoad")
        self.postNotification("viewDidLoad")
    }

    deinit
    {
        print("deinit")
        self.unRegisterAllNotification()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("-->viewWillAppear")
        self.postNotification("viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("-->viewDidAppear")
        self.postNotification("viewDidAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("-->viewWillDisappear")
        self.postNotification("viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("-->viewDidDisappear")
        self.postNotification("viewDidDisappear")
    }
    
    func testNotification(notification:NSNotification)
    {
        if notification.isNotification("viewDidLoad"){
           print("1=>\(notification.name)")
        }else if notification.isNotification("viewWillAppear"){
           print("2=>\(notification.name)")
        }else if notification.isNotification("viewDidAppear"){
           print("3=>\(notification.name)")
        }else if notification.isNotification("viewWillDisappear"){
           print("4=>\(notification.name)")
        }else if notification.isNotification("viewDidDisappear"){
           print("5=>\(notification.name)")
        }
    }

}
