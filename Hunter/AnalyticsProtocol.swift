//
//  AnalyticsProtocol.swift
//  SportsCat
//
//  Created by George Chernov on 01/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//



// it's not used now, I don't know how to do it properly
import Foundation

protocol AnalyticsProtocol
{
    class func start(sessionKey:String)
    
    class func log(eventName:String)
    class func timeLogStart(eventName:String)
    class func timeLogStart(eventName:String, params:[String: String])
    class func timeLogStop(eventName:String)
    class func timeLogStop(eventName:String, params:[String: String])

}