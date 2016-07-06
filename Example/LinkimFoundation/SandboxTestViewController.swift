//
//  SandboxTestViewController.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/5.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation

class SandboxTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        
        let documentPath = Sandbox.documentPath
        print(documentPath)
        
        let size = Sandbox.getFileSize(documentPath+"/UICollectionView.pdf")
        print(size)
        print(Sandbox.human(size))
        
        let libraryPath = Sandbox.libraryPath
        print(libraryPath)
        
        let libraryCachesPath = Sandbox.libraryCachesPath
        print(libraryCachesPath)
        
        let tmpPath = Sandbox.tmpPath
        print(tmpPath)
        
    }

   

}
