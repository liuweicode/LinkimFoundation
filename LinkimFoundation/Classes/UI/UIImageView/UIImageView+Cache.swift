//
//  UIImageView+Cache.swift
//  Pods
//
//  Created by Vic on 16/7/4.
//
//

import Foundation

typealias CacheImageCompletedBlock = (image: UIImage, error: NSError) -> Void
typealias CacheImageProgressBlock  = (receivedSize: Int, expectedSize: Int) -> Void

public enum LoadImageAnimationType: Int {
    case AnimationNone
    case AnimationFadeIn
}

extension UIImageView {
    /**
     *  异步加载一张图片
     *
     *  @param url 图片url
     */
    public func cacheWith(urlString: String) {
        self.cacheWith(urlString, placehold: nil)
    }
    /**
     *  异步加载一张图片
     *
     *  @param url          图片url
     *  @param defaultImage 默认图片
     */
    public func cacheWith(urlString: String, placehold: String?) {
        self.cacheWith(urlString, placehold: placehold, progressBlock: nil, completedBlock: nil)
    }
    /**
     *  异步加载一张图片
     *
     *  @param url          图片url
     *  @param defaultImage 默认图片
     *  @param type         动画效果类型
     */
    public func cacheWith(urlString: String, placehold: String?, animationType: LoadImageAnimationType) {
        switch animationType {
        case .AnimationNone:
            break
        default:
            break
        }
        if placehold != nil {
            self.image = UIImage(named: placehold!)
        }
        //self.sd_setImageWithURL(NSURL(string: urlString))
    }
    /**
     *  异步加载一张图片
     *
     *  @param url            图片url
     *  @param defaultImage   默认图片
     *  @param completedBlock 完成回调
     */
    private func cacheWith(urlString: String, placehold: String?, completedBlock: CacheImageCompletedBlock) {
        
    }
    /**
     *  异步加载一张图片
     *
     *  @param url            图片url
     *  @param progressBlock  进度回调
     *  @param completedBlock 完成回调
     */
    private func cacheWith(urlString: String, progressBlock: CacheImageProgressBlock, completedBlock: CacheImageCompletedBlock) {
    }
    /**
     *  异步缓存一张图片
     *
     *  @param url            图片url
     *  @param defaultImage   默认图片
     *  @param progressBlock  进度回调
     *  @param completedBlock 完成回调
     */
    private func cacheWith(urlString: String, placehold: String?, progressBlock: CacheImageProgressBlock?, completedBlock: CacheImageCompletedBlock?) {
    }
    
    
}