//
//  Fly.swift
//  SportsCat
//
//  Created by George Chernov on 03/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import SpriteKit

class Fly : Prey
{
    override init() {
        
        super.init()
    }
    
    override init(texture: SKTexture, color: SKColor, size: CGSize)
    {
        super.init(texture:texture, color:color, size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func preyCaught()
    {
        fatalError("preyCaught() has to be overrided")
    }
    
    override func failedAttemptToCatch(touchPosition:CGPoint)
    {
        fatalError("failedAttemptToCatch(touchPosition:CGPoint) has to be overrided")
    }

}