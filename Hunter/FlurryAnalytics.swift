//
//  FlurryAnalytics.swift
//  SportsCat
//
//  Created by George Chernov on 01/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation

class FlurryAnalytics
{
    
    struct Holder {
        static var timeLogger = Dictionary<String, NSDate>()
        static var currentScreen = 0
    }
    
    
    class func start(sessionKey:String)
    {
        Flurry.startSession(sessionKey)
        Flurry.setCrashReportingEnabled(true)
        Flurry.setDebugLogEnabled(true)
    }
    
    class func log(eventName:String)
    {
        Flurry.logEvent(eventName)
    }
    
    class func timeLogStart(eventName:String)
    {
        //Flurry.logEvent(eventName, timed: true)
        Flurry.logEvent(eventName)
        Holder.timeLogger[eventName] = NSDate()
    }
    
    class func timeLogStart(eventName:String, params:[String: String])
    {
        //Flurry.logEvent(eventName, withParameters: params, timed: true)
        Flurry.logEvent(eventName, withParameters: params)
        Holder.timeLogger[eventName] = NSDate()
    }
    
    class func timeLogStop(eventName:String)
    {
        if(Holder.timeLogger[eventName] != nil)
        {
            let timeInterval: Int32 = Int32(NSDate().timeIntervalSinceDate(Holder.timeLogger[eventName]!))
            //Flurry.endTimedEvent(eventName, withParameters:["duration": timeInterval.description])
            Flurry.logEvent(eventName + "_end", withParameters:["duration": timeInterval.description])
        }
        else
        {
            Flurry.logEvent(eventName + "_end")
        }
        
        Holder.timeLogger.removeValueForKey(eventName)
    }
    
    class func timeLogStop(eventName:String, params:[String: String])
    {
        // have no meaning -> just to fix bug with swift
        // https://teamtreehouse.com/forum/it-seems-to-be-an-error-in-swift-basics-what-is-dictionary-code-challenge
        var paramsLocal:[String: String] = params
        
        if(Holder.timeLogger[eventName] != nil)
        {
            var timeInterval: Int32 = Int32(NSDate().timeIntervalSinceDate(Holder.timeLogger[eventName]!))
            paramsLocal["duration"] = timeInterval.description
        }
        
        //Flurry.endTimedEvent(eventName, withParameters:paramsLocal)
        Flurry.logEvent(eventName + "_end", withParameters:paramsLocal)
        
        Holder.timeLogger.removeValueForKey(eventName)
    }
    
    class func stopCurrentTimeLog()
    {
        if(Holder.currentScreen == 0)
        {
            return
        }
        
        log("Home pressed")
        
        if(Holder.currentScreen == 1)
        {
            timeLogStop("FirstScreen duration")
        }
        
        if(Holder.currentScreen == 2)
        {
            timeLogStop("SecondScreen duration")
        }
        
        if(Holder.currentScreen == 3)
        {
            timeLogStop("SettingsScreen duration")
        }
    }
    
    class func startCurrentTimeLog()
    {
        if(Holder.currentScreen == 0)
        {
            return
        }
        
        log("Back after Home")
        
        if(Holder.currentScreen == 1)
        {
            timeLogStart("FirstScreen duration")
        }
        
        if(Holder.currentScreen == 2)
        {
            timeLogStart("SecondScreen duration")
        }
        
        if(Holder.currentScreen == 3)
        {
            timeLogStart("SettingsScreen duration")
        }
    }
    
}
