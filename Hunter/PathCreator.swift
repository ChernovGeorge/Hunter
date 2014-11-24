//
//  MovementCreator.swift
//  TestGame
//
//  Created by George Chernov on 16/08/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation
import UIKit

class PathCreator
{
    
    var maxX:Int32 = 1024
    var maxY:Int32 = 768
    
    func GetPath(startPoint:CGPoint) -> (path:UIBezierPath, lastPoint:CGPoint)
    {
        fatalError("This method must be overridden")
    }
    
    func getCountOfPathes(minCount:Int32, maxCount:Int32) -> Int32
    {
        var limitedRandom:Int32 = Int32(arc4random() % UInt32(maxCount));
        return (limitedRandom < (maxCount - minCount)) ? (limitedRandom + (maxCount - minCount)): limitedRandom;
    }
    
}
