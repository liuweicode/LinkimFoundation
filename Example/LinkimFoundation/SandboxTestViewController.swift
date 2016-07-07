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
        print("document Path => \(documentPath)")
        let documentSize = Sandbox.getFileSize(documentPath)
        print("document size => \(documentSize)")
        print("document human size => \(Sandbox.human(documentSize))")
        
        let libraryPath = Sandbox.libraryPath
        print("\r\n\r\nLibrary Path => \(libraryPath)")
        let librarySize = Sandbox.getFileSize(libraryPath)
        print("library size => \(librarySize)")
        print("library human size => \(Sandbox.human(librarySize))")
        
        let libraryCachesPath = Sandbox.libraryCachesPath
        print("\r\n\r\nLibrary Cache Path => \(libraryCachesPath)")
        let libraryCachesSize = Sandbox.getFileSize(libraryCachesPath)
        print("libraryCaches size => \(libraryCachesSize)")
        print("libraryCaches human size => \(Sandbox.human(libraryCachesSize))")
        
        let tmpPath = Sandbox.tmpPath
        print("\r\n\r\nTemp Path => \(tmpPath)")
        let tmpSize = Sandbox.getFileSize(tmpPath)
        print("tmp size => \(tmpSize)")
        print("tmp human size => \(Sandbox.human(tmpSize))")
        
        let filePath = tmpPath + "\test.txt"
        Sandbox.touchFile(filePath, deleteWhenExists: true)
        for _ in 0...20 {
            Sandbox.writeAppendContent("1234567890", filePath: filePath)
        }
        let afterTmpSize = Sandbox.getFileSize(tmpPath)
        print("after tmp size => \(afterTmpSize)")
        print("after tmp human size => \(Sandbox.human(afterTmpSize))")
        
    }

   

}
