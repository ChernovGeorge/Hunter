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
    // the location of the hole, the place where the mouse go from
    let holeLocation = CGPoint(x: 1200, y: 600)
    
    let textureAtlas = SKTextureAtlas(named:"fly")
    var spriteArray = Array<SKTexture>()
    
    var pathCreator = FlyPathCreator(maxCountOfPathes: 4)
    var movingStartPosition = CGPoint(x: 1000, y: 600)
    
    override init() {
        
        super.init()
        
        spriteArray.append(textureAtlas.textureNamed("Fly1"))
        spriteArray.append(textureAtlas.textureNamed("Fly2"))
        //spriteArray.append(textureAtlas.textureNamed("Fly3"))
        //spriteArray.append(textureAtlas.textureNamed("Fly4"))
        spriteArray.append(textureAtlas.textureNamed("Fly5"))
        spriteArray.append(textureAtlas.textureNamed("Fly6"))
        spriteArray.append(textureAtlas.textureNamed("Fly7"))
        spriteArray.append(textureAtlas.textureNamed("Fly8"))
        spriteArray.append(textureAtlas.textureNamed("Fly9"))
        //spriteArray.append(textureAtlas.textureNamed("Fly10"))
        
        var texture = spriteArray[0]
        
        self.texture = texture
        self.size = CGSize(width: texture.size().width, height: texture.size().height)
        self.position = holeLocation
        
        move()
        startTextureChangingAction()
    }
    
    override init(texture: SKTexture, color: SKColor, size: CGSize)
    {
        super.init(texture:texture, color:color, size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    // public
    
    override func preyCaught()
    {
//        flyCaughtEffectPlay()
//        
//        FlurryAnalytics.log("Pray was caught")
    }
    override func failedAttemptToCatch(touchPosition:CGPoint)
    {
//        if(isTouchCloseToMouse(self.position, touchPosition:touchPosition))
//        {
//            preyEscaped()
//            FlurryAnalytics.log("Touch close to mouse")
//            
//        }
//        else
//        {
//            FlurryAnalytics.log("Touch background")
//        }
        
    }
    
    
    // private
    
    func startTextureChangingAction()
    {
        var changeTextureAction = SKAction.animateWithTextures(spriteArray, timePerFrame: 0.10);
        var repeatAction = SKAction.repeatActionForever(changeTextureAction);
        self.runAction(repeatAction);
    }
    
    func move()
    {
        
        
        var pathWithLastPoint = pathCreator.GetPath(movingStartPosition);
        
        var bp:UIBezierPath = pathWithLastPoint.path
        movingStartPosition = pathWithLastPoint.lastPoint
        
        var duration = getDuration()
        
        var mouseMoveAction = SKAction.followPath(bp.CGPath, asOffset:false, orientToPath:true, duration: duration);
        var waiting = SKAction.waitForDuration(20)
        var sound = SKAction.playSoundFileNamed("caughtFly.mp3", waitForCompletion: false)
        var group = SKAction.group([mouseMoveAction, sound])
        
        var sequence = SKAction.sequence([waiting, group])
        
        runAction(sequence, move)
    }
    
    func preyEscaped()
    {
        
        //mouseEscapedEffectPlay()
        
        // TODO: to investigate: use runAction:withKey, it removes the existing action automaticaly
        removeAllActions()
        
        startTextureChangingAction()
        
        var pathWithLastPoint = pathCreator.GetPath(holeLocation);
        
        var bp:UIBezierPath = pathWithLastPoint.path
        movingStartPosition = pathWithLastPoint.lastPoint
        
        var pathBackToHole = CGPathCreateMutable();
        CGPathMoveToPoint(pathBackToHole, nil, self.position.x, self.position.y)
        CGPathAddLineToPoint(pathBackToHole, nil, holeLocation.x, holeLocation.y)
        
        // TODO: maybe it will be suitable to use constant speed of the mouse during path,
        // to get it I have to calculate the duration
        // it can make the mouse movement more natural
        var act1 = SKAction.followPath(pathBackToHole, asOffset: false, orientToPath: true, duration: 0.3)
        var act2 = SKAction.followPath(bp.CGPath, asOffset:false, orientToPath:true, duration: getDuration());
        
        var sequence = SKAction.sequence([act1, act2])
        runAction(sequence, move)
        
    }
    
    func isTouchCloseToMouse(mousePosition: CGPoint, touchPosition: CGPoint) -> Bool
    {
        var x = abs(mousePosition.x - touchPosition.x)
        var y = abs(mousePosition.y - touchPosition.y)
        
        if(x > 0 && x < 200 && y > 0 && y < 200)
        {
            return true;
        }
        
        return false;
    }
    
    func getDuration() -> NSTimeInterval
    {
        var limitedRandom:Int32 = Int32(arc4random() % UInt32(4));
        return NSTimeInterval((limitedRandom < 2) ? (limitedRandom + 3): limitedRandom);
    }


}