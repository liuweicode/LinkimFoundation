//
//  Sandbox.swift
//  Pods
//
//  Created by 刘伟 on 16/7/4.
//
//

import UIKit

public class Sandbox: NSObject {

    
    public static func readBundleContentOfFileName(fileName:String,type:String) throws -> String? {
        
        let bundle = NSBundle.mainBundle()
        
        var content:String?
        
        if let path = bundle.pathForResource(fileName, ofType: type)
        {
            content = try String(contentsOfFile: path, encoding:NSUTF8StringEncoding)
        }
       return content
    }
    

    public static func readBundleJsonContentOfFileName(fileName:String) -> String? {
        
        var content:String?

        do{
            try content = self.readBundleContentOfFileName(fileName, type: "json")
        }catch{
            debugPrint("加载Json配置出错")
        }
        
        guard let con = content else{
            debugPrint("没有读取到JSON内容")
            return nil
        }
        
        return content
    }
}





















