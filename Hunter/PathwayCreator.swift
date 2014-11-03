//
//  MovementCreator.swift
//  TestGame
//
//  Created by George Chernov on 16/08/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation
import UIKit

class PathwayCreator
{
    var startPoint = CGPoint(x: 1000, y: 600)
    var maxCountOfPathes:Int32 = 0
    
    var maxX:Int32 = 1024
    var maxY:Int32 = 768
    
    init(startPoint:CGPoint, maxCountOfPathes:Int32)
    {
        self.startPoint = startPoint
        self.maxCountOfPathes = maxCountOfPathes
    }
    
    func GetPath() -> UIBezierPath
    {
        var countOfPathesLocal = getCountOfPathes();
        
        var path = UIBezierPath()
        
        //firstly go to start
        path.moveToPoint(startPoint)
        
        var lastPoint = CGPoint(x: startPoint.x, y: startPoint.y)

        var lastControlPoint = CGPoint(x: getRandomW(), y: getRandomH())
        
        for _ in 1...countOfPathesLocal {
            
            var currentControlPoint = CGPoint(x: getRandomW(), y: getRandomH())
            var currentPoint = CGPoint(x: (lastPoint.x + currentControlPoint.x)/2, y: (lastPoint.y + currentControlPoint.y)/2)
            
            path.addQuadCurveToPoint(currentPoint, controlPoint: lastControlPoint)
            
            lastPoint = currentPoint
            lastControlPoint = currentControlPoint
            
        }
        
        path.addQuadCurveToPoint(startPoint, controlPoint: lastControlPoint)
        
        return path;
    }
    
    //Count of Pathes the mouse takes before gets a peace of cheese
    func getCountOfPathes() -> Int32
    {
        var limitedRandom:Int32 = Int32(arc4random() % UInt32(maxCountOfPathes));
        
        //number of pathes between 20 - 30
        return (limitedRandom < (maxCountOfPathes - 6)) ? (limitedRandom + (maxCountOfPathes - 6)): limitedRandom;
    }
    
    func getRandomH() -> CGFloat
    {
        var limitedRandom:Int32 = (Int32(arc4random() % UInt32(maxY + 200))) - 100
        return CGFloat(limitedRandom < 40 ? (limitedRandom + 40): limitedRandom);
    }
    
    func getRandomW() -> CGFloat
    {
        var limitedRandom:Int32 = (Int32(arc4random() % UInt32(maxY + 200))) - 100
        return CGFloat(limitedRandom < 40 ? (limitedRandom + 40): limitedRandom);
    }
}
