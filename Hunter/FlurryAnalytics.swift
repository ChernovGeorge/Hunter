//
//  FlurryAnalytics.swift
//  SportsCat
//
//  Created by George Chernov on 01/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation

class FlurryAnalytics: AnalyticsProtocol
{
    
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
        Flurry.logEvent(eventName, timed: true)
    }
    
    class func timeLogStop(eventName:String)
    {
        Flurry.endTimedEvent(eventName, withParameters:nil)
    }
    
}
