//
//  MovementCreator.swift
//  TestGame
//
//  Created by George Chernov on 16/08/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation

class PathCreator
{
    
    private var maxX:Int32 = 1024
    private var maxY:Int32 = 768
    
    func GetPath(startPoint:CGPoint) -> (path:UIBezierPath, lastPoint:CGPoint)
    {
        fatalError("This method must be overridden")
    }
    
    func getMaxXY() -> (x:Int32, y:Int32)
    {
        return (maxX, maxY)
    }
    
    func getRandomPoint() -> CGPoint
    {
        return CGPoint(x: getRandomW(), y: getRandomH())
    }
    
    func getCountOfPathes(minCount:Int32, maxCount:Int32) -> Int32
    {
        var limitedRandom:Int32 = Int32(arc4random() % UInt32(maxCount));
        return (limitedRandom < (maxCount - minCount)) ? (limitedRandom + (maxCount - minCount)): limitedRandom;
    }
    
    
    private func getRandomH() -> CGFloat
    {
        var limitedRandom:Int32 = (Int32(arc4random() % UInt32(maxY + 200))) - 100
        return CGFloat(limitedRandom < 40 ? (limitedRandom + 40): limitedRandom);
    }
    
    private func getRandomW() -> CGFloat
    {
        var limitedRandom:Int32 = (Int32(arc4random() % UInt32(maxY + 200))) - 100
        return CGFloat(limitedRandom < 40 ? (limitedRandom + 40): limitedRandom);
    }
    
}
