//
//  AppDelegate.swift
//  LinkimFoundation
//
//  Created by liuwei on 06/30/2016.
//  Copyright (c) 2016 liuwei. All rights reserved.
//

import UIKit
import CoreGraphics
import LinkimFoundation
import IQKeyboardManagerSwift
import PKHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var reachability: Reachability?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
        
//        let mainController = MainViewController()
//        let navigationController = UINavigationController(rootViewController: mainController)
//        self.window?.rootViewController = navigationController
        
        let tabBarController = TabBarController()
        self.window?.rootViewController = tabBarController
        
        self.window?.makeKeyAndVisible()
        
        // 监听网络连接状态
        self.startInternetConnectionMonitoring()
        return true
    }

    func startInternetConnectionMonitoring()
    {
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityChanged(_:)),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            debugPrint("could not start reachability notifier")
        }
    }
   
    // 网络状态通知
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                
                #if DEBUG
                    print("DEBUG WiFi网络")
                #endif
                
                #if INHOUSE
                    print("INHOUSE WiFi网络")
                #endif
                
            } else {
                print("手机网络")
            }
        } else {
            
            #if DEBUG
                print("DEBUG 没有网络")
            #endif
            
            #if INHOUSE
                print("INHOUSE 没有网络")
            #endif
            
            
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

