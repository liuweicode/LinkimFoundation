//
//  Sandbox.swift
//  Pods
//
//  Created by 刘伟 on 16/7/4.
//
//

import UIKit
import Foundation

public class Sandbox: NSObject {
    
    // Documents 会被iTunes同步
    public static let documentPath:String = {
        return NSHomeDirectory() + "/Documents"
    }()
    
    // Library 会被iTunes同步
    public static let libraryPath:String =
    {
        return NSHomeDirectory() + "/Library"
    }()
    
    // 存放缓存文件，不会被iTunes同步
    public static let libraryCachesPath:String = {
       return NSHomeDirectory() + "/Library/Caches"
    }()
    
    // 沙盒临时目录 app退出后可能会被删除
    public static let tmpPath:String = {
        return NSTemporaryDirectory()
    }()
    
    
    /**
     判断文件(夹)是否存在
     
     - parameter filePath: 文件(夹)路径
     
     - returns: true / false
     */
    public static func isFileExists(filePath:String) -> Bool
    {
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    /**
     删除指定文件或目录
     
     - parameter path: 文件(夹)路径
     
     - returns: true / false
     */
    public static func remove(path:String) -> Bool
    {
        var result = true
        do{
          try NSFileManager.defaultManager().removeItemAtPath(path)
        }catch let error as NSError {
            debugPrint(error.description)
            result = true
        }
        return result
    }
    
    /**
     创建文件夹
     
     - parameter directoryPath: 文件夹路径
     
     - returns: true / false
     */
    public static func mkdir(directoryPath:String) -> Bool
    {
        var result = true
        if NSFileManager.defaultManager().fileExistsAtPath(directoryPath) == false
        {
            do{
                try NSFileManager.defaultManager().createDirectoryAtPath(directoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch let error as NSError{
                debugPrint(error.description)
                result = false
            }
        }
        return result
    }
    
    /**
     创建文件
     
     - parameter filePath:         文件路径
     - parameter deleteWhenExists: 如果文件存在是否先删除再创建，默认`是`
     
     - returns: true / false
     */
    public static func touchFile(filePath:String,deleteWhenExists:Bool = true) -> Bool
    {
        var result = true
        if Sandbox.isFileExists(filePath) {
            if deleteWhenExists {
                Sandbox.remove(filePath)
                do{
                    try NSFileManager.defaultManager().createFileAtPath(filePath, contents: NSData(), attributes: nil)
                }catch let error as NSError{
                    debugPrint(error.description)
                    result = false
                }
            }else{
                // 不做任何事情
            }
        }else{
            do{
                try NSFileManager.defaultManager().createFileAtPath(filePath, contents: NSData(), attributes: nil)
            }catch let error as NSError{
                debugPrint(error.description)
                result = false
            }
        }
        return result
    }
    
    public static func human(fileSize: UInt64) -> String {
        let sizeClasses = [
            (UInt64(1024 * 1024 * 1024), "GB"),
            (UInt64(1024 * 1024), "MB"),
            (UInt64(1024), "KB"),
            ]
        for (size, unit) in sizeClasses {
            if fileSize >= size {
                let sizeInUnit = Double(fileSize) / Double(size)
                return String(format: "%0.2f\(unit)", sizeInUnit)
            }
        }
        return "\(fileSize)B"
    }
    
    /**
     如果该路径是文件，则返回文件大小 
     如果该路径是目录，则返回目录下所有文件大小总和
     
     - parameter filePath: 文件(夹)路径
     
     - returns: 文件大小
     */
    public static func getFileSize(filePath:String) -> UInt64
    {
        let fileManager = NSFileManager.defaultManager()
        var bool: ObjCBool = false
        if fileManager.fileExistsAtPath(filePath, isDirectory: &bool) {
            // 是目录
            if bool.boolValue {
                var folderFileSizeInBytes:UInt64 = 0
                if let filesEnumerator = fileManager.enumeratorAtURL(NSURL(fileURLWithPath: filePath, isDirectory: true), includingPropertiesForKeys: nil, options: [], errorHandler: {
                    (url, error) -> Bool in
                    debugPrint(url.path!)
                    debugPrint(error.localizedDescription)
                    return true
                }) {
                    while let fileURL = filesEnumerator.nextObject() as? NSURL {
                        do {
                            let attributes = try fileManager.attributesOfItemAtPath(fileURL.path!) as NSDictionary
                            folderFileSizeInBytes += UInt64(attributes.fileSize().hashValue)
                        } catch let error as NSError {
                            debugPrint(error.localizedDescription)
                        }
                    }
                }
//                let  byteCountFormatter =  NSByteCountFormatter()
//                byteCountFormatter.allowedUnits = .UseBytes
//                byteCountFormatter.countStyle = .File
//                let folderSizeToDisplay = byteCountFormatter.stringFromByteCount(Int64(folderFileSizeInBytes))
//                debugPrint(folderSizeToDisplay)  // "X,XXX,XXX bytes"
                return folderFileSizeInBytes
            }else{
                do{
                    let attributes :NSDictionary = try NSFileManager.defaultManager().attributesOfItemAtPath(filePath)
                    var fileSizeInBytes:UInt64 = 0
                    fileSizeInBytes = UInt64(attributes.fileSize().hashValue)
                    return fileSizeInBytes
                }catch let error as NSError{
                    debugPrint(error.description)
                }
            }
        }
        return 0
    }
    
    /**
     读取指定文件内容
     
     - parameter filePath: 文件路径
     
     - returns: UTF8编码内容字符串
     */
    public static func readStringWithContentsOfFile(filePath:String) -> String?
    {
        var content:String? = nil
        if Sandbox.isFileExists(filePath) {
            do{
                content = try String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
            }catch let error as NSError{
                debugPrint(error.description)
            }
        }
        return content
    }
    
    /**
     读取指定文件内容
     
     - parameter filePath: 文件路径
     
     - returns: data
     */
    public static func readDataWithContentsOfFile(filePath:String) -> NSData?
    {
        var content:NSData? = nil
        if Sandbox.isFileExists(filePath) {
            content = NSData(contentsOfFile: filePath)
        }
        return content
    }
    
    /**
     写字符串到文件
     
     - parameter content:  字符串内容
     - parameter filePath: 文件路径
     
     - returns: 是否写入成功
     */
    public static func writeContent(content:String, filePath:String) -> Bool
    {
        var result = true
        do{
            try content.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        }catch let error as NSError{
            debugPrint(error.description)
            result = false
        }
        return result
    }
    
    /**
     写data到文件
     
     - parameter data:     NSData
     - parameter filePath: 文件路径
     
     - returns: 是否写入成功
     */
    public static func writeData(data:NSData, filePath:String) -> Bool
    {
        return data.writeToFile(filePath, atomically: true)
    }
    
    /**
     追加字符串到文件
     
     - parameter content:  字符串
     - parameter filePath: 文件路径
     
     - returns: 是否写入成功
     */
    public static func writeAppendContent(content:String, filePath:String) -> Bool
    {
        if !Sandbox.isFileExists(filePath) {
            Sandbox.touchFile(filePath)
        }
        
        if let data = content.dataUsingEncoding(NSUTF8StringEncoding)
        {
            if let fileHandler = NSFileHandle(forUpdatingAtPath: filePath)
            {
                fileHandler.seekToEndOfFile()
                
                fileHandler.writeData(data)
                
                return true
            }
        }
        return false
    }
    
    /**
     追加data到文件
     
     - parameter data:     NSData
     - parameter filePath: 文件路径
     
     - returns: 是否写入成功
     */
    public static func writeAppendData(data:NSData, filePath:String) -> Bool
    {
        if !Sandbox.isFileExists(filePath) {
            Sandbox.touchFile(filePath)
        }
        
        if let fileHandler = NSFileHandle(forUpdatingAtPath: filePath)
        {
            fileHandler.seekToEndOfFile()
            
            fileHandler.writeData(data)
            
            return true
        }
        return false
    }
    
    /**
     删除指定目录下所有文件
     
     - parameter directory: 目录路径
     */
    public static func removeAllFilesWithDirectory(directory:String)
    {
        if let files = NSFileManager.defaultManager().subpathsAtPath(directory)
        {
            for p in files {
                let path = directory + p
                if NSFileManager.defaultManager().fileExistsAtPath(path) {
                    do{
                        debugPrint("删除:\(path)")
                        try NSFileManager.defaultManager().removeItemAtPath(path)
                    }catch let error as NSError{
                        debugPrint(error.description)
                    }
                }
            }
        }
    }
    
    /**
     读取当前Bundle中文件内容
     
     - parameter fileName: 文件名
     - parameter type:     文件拓展名
     
     - throws: 如果读取失败则抛出异常
     
     - returns: UTF8编码内容字符串
     */
    public static func readBundleContentOfFileName(fileName:String,type:String) throws -> String? {
        
        let bundle = NSBundle.mainBundle()
        
        var content:String?
        
        if let path = bundle.pathForResource(fileName, ofType: type)
        {
            content = try String(contentsOfFile: path, encoding:NSUTF8StringEncoding)
        }
       return content
    }
    

    /**
     读取当前Bundle中Json文件内容
     
     - parameter fileName: 文件名
     
     - returns: UTF8编码内容字符串
     */
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
