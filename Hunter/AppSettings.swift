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
    
    func getSpeed() -> Int32
    {
        var speed = Int32(NSUserDefaults.standardUserDefaults().integerForKey("preyspeed"))
        
        // if speed is not setted use 3 that is middle speed
        if(speed == 0)
        {
            speed = 3
        }
        
        return speed
    }
    
    func setSpeed(speed:Int32)
    {
        NSUserDefaults.standardUserDefaults().setInteger(Int(speed), forKey: "preyspeed")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
