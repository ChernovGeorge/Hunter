//
//  MousePathCreator.swift
//  SportsCat
//
//  Created by George Chernov on 24/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation

class MousePathCreator: PathCreator
{
    
    var maxCountOfPathes:Int32 = 0
    
    init(maxCountOfPathes:Int32)
    {
        self.maxCountOfPathes = maxCountOfPathes
    }
    
    override func GetPath(startPoint:CGPoint) -> (path:UIBezierPath, lastPoint:CGPoint)
    {
        var countOfPathesLocal = getCountOfPathes(4, maxCount: maxCountOfPathes);
        
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
        
        // mouse shouldn't go to the hole
        //path.addQuadCurveToPoint(startPoint, controlPoint: lastControlPoint)
        
        return (path, lastPoint);
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
