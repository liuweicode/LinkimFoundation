//
//  StringDemoViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/1.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class StringDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        var str : String?
        var b = str?.isBlank()
        print("\(b)")
        
        let len = str?.length
        print("\(len)")
        
        str = ""
        b = str?.isBlank()
        print("\(b)")
        
        str = "  "
        b = str?.isBlank()
        print("\(b)")
        
        str = " 1 "
        b = str?.isBlank()
        print("\(b)")
        
        let length = str?.length
        print("\(length)")
        
        let size = str?.sizeWithFont(font: UIFont.systemFontOfSize(12), maxSize: CGSize(width: 100, height: 100))
        print("\(size)")
     
    }

}
