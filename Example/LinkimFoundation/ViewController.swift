//
//  ViewController.swift
//  LinkimFoundation
//
//  Created by liuwei on 06/30/2016.
//  Copyright (c) 2016 liuwei. All rights reserved.
//

import UIKit
import LinkimFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer(selector: #selector(test(_:)), timeInterval: 1, repeats: true, name: "123")
    }
    
    func test(timer:NSTimer)
    {
        print("==>\(timer.timeName) \r\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

