////
////  UIImageView+Cache.swift
////  Pods
////
////  Created by Vic on 16/7/4.
////
////
//
//import Foundation
//
//public enum LoadImageAnimationType: Int {
//    case AnimationNone
//    case AnimationFadeIn
//}
//
//extension UIImageView {
//    /**
//     *  异步加载一张图片
//     *
//     *  @param url 图片url
//     */
//    public func cacheWith(urlString: String) {
//        //self.sd_setImageWithURL(NSURL(string: urlString))
//    }
//    /**
//     *  异步加载一张图片
//     *
//     *  @param url          图片url
//     *  @param defaultImage 默认图片
//     */
//    public func cacheWith(urlString: String, placehold: String?) {
//        if placehold != nil {
//            self.image = UIImage(named: placehold!)
//        }
//        //self.sd_setImageWithURL(NSURL(string: urlString))
//    }
//    /**
//     *  异步下载一张图片
//     *
//     *  @param url          图片url
//     *  @param defaultImage 默认图片
//     *  @param type         动画效果类型
//     */
//    public func cacheWith(urlString: String, placehold: String?, animationType: LoadImageAnimationType) {
//        if placehold != nil {
//            self.image = UIImage(named: placehold!)
//        }
//        //self.sd_setImageWithURL(NSURL(string: urlString))
//    }
//    /**
//     *  异步下载一张图片
//     *
//     *  @param url            图片url
//     *  @param defaultImage   默认图片
//     *  @param completedBlock 完成回调
//     */
//    public func cacheWith(urlString: String, placehold: String?, )
//    
//    
//}