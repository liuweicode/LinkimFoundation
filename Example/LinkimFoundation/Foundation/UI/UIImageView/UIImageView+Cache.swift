//
//  UIImageView+Cache.swift
//  Pods
//
//  Created by Vic on 16/7/4.
//
//

import Foundation
import SDWebImage

typealias CacheImageCompletedBlock = (image: UIImage?, error: NSError?) -> Void
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
            self.cacheWith(urlString, placehold: placehold, progressBlock: nil, completedBlock: nil)
        case .AnimationFadeIn:
            self.cacheWith(urlString, placehold: placehold, progressBlock: nil, completedBlock: { (image, error) in
                if image != nil {
                    self.alpha = 0
                    UIView.animateWithDuration(0.5, animations: { 
                        self.alpha = 1
                    })
                }
            })
        }
    }
    /**
     *  异步加载一张图片
     *
     *  @param url            图片url
     *  @param defaultImage   默认图片
     *  @param completedBlock 完成回调
     */
    private func cacheWith(urlString: String, placehold: String?, completedBlock: CacheImageCompletedBlock) {
        self.cacheWith(urlString, placehold: placehold, progressBlock: nil, completedBlock: completedBlock)
    }
    /**
     *  异步加载一张图片
     *
     *  @param url            图片url
     *  @param progressBlock  进度回调
     *  @param completedBlock 完成回调
     */
    private func cacheWith(urlString: String, progressBlock: CacheImageProgressBlock, completedBlock: CacheImageCompletedBlock) {
        self.cacheWith(urlString, placehold: nil, progressBlock: progressBlock, completedBlock: completedBlock)
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
        //SDWebImage
        
    }
}