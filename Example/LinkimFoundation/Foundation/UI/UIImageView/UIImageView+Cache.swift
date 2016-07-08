//
//  UIImageView+Cache.swift
//  Pods
//
//  Created by Vic on 16/7/4.
//
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

typealias CacheImageCompletedBlock = (image: UIImage?, error: NSError?) -> Void
typealias CacheImageProgressBlock  = (receivedSize: Int, expectedSize: Int) -> Void

public enum LoadImageAnimationType: Int {
    case AnimationNone
    case AnimationFadeIn
}

extension UIImageView {
    
    /**
     异步加载一张图片
     
     - parameter URL:                        图片URL
     - parameter placeholderImage:           默认图片
     - parameter filter:                     过滤器
     - parameter progress:                   下载进度
     - parameter progressQueue:              处理队列
     - parameter imageTransition:            动画
     - parameter runImageTransitionIfCached: 如果图片被缓存是否执行过渡动画
     - parameter completion:                 完成回调
     */
    public func cacheWith(
        URL: NSURL,
        placeholderImage: UIImage? = nil,
        filter: ImageFilter? = nil,
        progress: ImageDownloader.ProgressHandler? = nil,
        progressQueue: dispatch_queue_t = dispatch_get_main_queue(),
        imageTransition: ImageTransition = .None,
        runImageTransitionIfCached: Bool = false,
        completion: (Response<UIImage, NSError> -> Void)? = nil)
    {
        self.af_setImageWithURL(URL, placeholderImage: placeholderImage, filter: filter, progress: progress, progressQueue: progressQueue, imageTransition: imageTransition, runImageTransitionIfCached: runImageTransitionIfCached, completion: completion)
    }
}