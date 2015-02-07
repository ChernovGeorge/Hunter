//
//  FlyPathCreator.swift
//  SportsCat
//
//  Created by George Chernov on 24/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation

class FlyPathCreator : PathCreator
{
    var maxCountOfPathes:Int32 = 0
    
    init(maxCountOfPathes:Int32)
    {
        self.maxCountOfPathes = maxCountOfPathes
    }
    
    override func GetPath(startPoint:CGPoint) -> (path:UIBezierPath, lastPoint:CGPoint)
    {
        var startFinishPoints = getRandomStartAndFinishPoints()
        var countOfPathesLocal = getCountOfPathes(2, maxCount: maxCountOfPathes);
        
        var path = UIBezierPath()
        
        //firstly go to start
        path.moveToPoint(startFinishPoints.start)
        
        var lastPoint = startFinishPoints.start
        
        var lastControlPoint = getRandomPoint()
        
        for _ in 1...countOfPathesLocal {
            
            var currentControlPoint = getRandomPoint()
            var currentPoint = CGPoint(x: (lastPoint.x + currentControlPoint.x)/2, y: (lastPoint.y + currentControlPoint.y)/2)
            
            path.addQuadCurveToPoint(currentPoint, controlPoint: lastControlPoint)
            
            lastPoint = currentPoint
            lastControlPoint = currentControlPoint
        }
        
        path.addQuadCurveToPoint(startFinishPoints.finish, controlPoint: lastControlPoint)
        
        return (path, lastPoint);
        
    }
    
    func getRandomStartAndFinishPoints()-> (start:CGPoint, finish:CGPoint)
    {
        var isFromRight:Bool = Int32(arc4random() % 2) == 0
        
        var startX:Int32 = isFromRight ? (getMaxXY().x + Int32(200)) : -100
        var startY:Int32 = (Int32(arc4random() % UInt32(getMaxXY().y + 200))) - 100
        var startPoint:CGPoint = CGPoint(x: Int(startX), y: Int(startY))
        
        var finishX:Int32 = isFromRight ? -100 : (getMaxXY().x + Int32(200))
        var finishY:Int32 = (Int32(arc4random() % UInt32(getMaxXY().y + 200))) - 100
        var finishPoint:CGPoint = CGPoint(x: Int(finishX), y: Int(finishY))
        
        return (startPoint, finishPoint)
    }
}
