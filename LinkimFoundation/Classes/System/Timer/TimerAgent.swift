//
//  TimerAgent.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import UIKit

public class TimerAgent: NSObject
{

    var timers: [NSTimer]!
    
    override init()
    {
        timers = [NSTimer]()
    }
    
    /**
     根据timer名称查找timer
     
     - parameter name: timer名称
     
     - returns: NSTimer
     */
    public func timerForName(name:String?) -> NSTimer?
    {
        for timer in timers {
            if timer.timeName == name || (timer.timeName == nil && name == nil){
                return timer
            }
        }
        return nil
    }
    
    deinit
    {
        for timer in timers {
            if timer.valid {
                timer.invalidate()
            }
        }
        timers.removeAll()
        timers = nil;
    }
}
