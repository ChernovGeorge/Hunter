//
//  AppSettings.swift
//  SportsCat
//
//  Created by George Chernov on 25/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation

class AppSettings
{
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    class func getSpeed() -> Int32
    {
        var speed = Int32(NSUserDefaults.standardUserDefaults().integerForKey("preyspeed"))
        
        if(speed == 0)
        {
            speed = 2
        }
        
        return speed
    }
    
    class func setSpeed(speed:Int32)
    {
        NSUserDefaults.standardUserDefaults().setInteger(Int(speed), forKey: "preyspeed")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func getBackground() -> Int32
    {
        var bgd = Int32(NSUserDefaults.standardUserDefaults().integerForKey("background"))
        
        if(bgd == 0)
        {
            bgd = 1
        }
        
        return bgd
    }
    
    class func setBackground(bgd:Int32)
    {
        NSUserDefaults.standardUserDefaults().setInteger(Int(bgd), forKey: "background")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
