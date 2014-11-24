//
//  Mouse.swift
//  Hunter
//
//  Created by George Chernov on 28/09/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import SpriteKit

class Mouse : Prey
{
    
    // the location of the hole, the place where the mouse go from
    let holeLocation = CGPoint(x: 1200, y: 600)
    
    let textureAtlas = SKTextureAtlas(named:"mouse2.atlas")
    var spriteArray = Array<SKTexture>()
    
    var pathCreator = MousePathCreator(maxCountOfPathes: 8)
    var movingStartPosition = CGPoint(x: 1000, y: 600)

    override init() {
        
        super.init()

        spriteArray.append(textureAtlas.textureNamed("M1"))
        spriteArray.append(textureAtlas.textureNamed("M2"))
        spriteArray.append(textureAtlas.textureNamed("M3"))
        spriteArray.append(textureAtlas.textureNamed("M4"))
        spriteArray.append(textureAtlas.textureNamed("M5"))
        spriteArray.append(textureAtlas.textureNamed("M6"))
        spriteArray.append(textureAtlas.textureNamed("M7"))
        
        var mouseTexture = spriteArray[0]
        
        self.texture = mouseTexture
        self.size = CGSize(width: mouseTexture.size().width, height: mouseTexture.size().height)
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
        mouseCaughtEffectPlay()
        
        FlurryAnalytics.log("Pray was caught")
    }
    override func failedAttemptToCatch(touchPosition:CGPoint)
    {
        if(isTouchCloseToMouse(self.position, touchPosition:touchPosition))
        {
            preyEscaped()
            FlurryAnalytics.log("Touch close to mouse")
            
        }
        else
        {
            FlurryAnalytics.log("Touch background")
        }

    }
    
    
    // private
    
    func startTextureChangingAction()
    {
        var changeTextureAction = SKAction.animateWithTextures(spriteArray, timePerFrame: 0.12);
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
    
        
        runAction(mouseMoveAction, complexMove)
    }
    
    func complexMove()
    {
        runAction(SKAction.waitForDuration(getDuration() / 10 * 5), move)
    }
    
    func preyEscaped()
    {

        mouseEscapedEffectPlay()
        
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
    
    func mouseEscapedEffectPlay()
    {
        audioPlayer.play()
    }
    
    func mouseCaughtEffectPlay()
    {
        self.runAction(SKAction.playSoundFileNamed("caughtMouse.mp3", waitForCompletion: false))
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
        var limitedRandom:Int32 = Int32(arc4random() % UInt32(5));
        return NSTimeInterval((limitedRandom < 2) ? (limitedRandom + 2): limitedRandom);
    }


}

