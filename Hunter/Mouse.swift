//
//  Mouse.swift
//  Hunter
//
//  Created by George Chernov on 28/09/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import SpriteKit

class Mouse : SKSpriteNode
{
    
    let textureAtlas = SKTextureAtlas(named:"mouse.atlas")
    var spriteArray = Array<SKTexture>()
    
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
        self.position = CGPoint(x: 200, y: 200)
        
    }
    
    override init(texture: SKTexture, color: SKColor, size: CGSize)
    {
        super.init(texture:texture, color:color, size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func startTextureChangingAction()
    {
        var changeTextureAction = SKAction.animateWithTextures(spriteArray, timePerFrame: 0.10);
        var repeatAction = SKAction.repeatActionForever(changeTextureAction);
        self.runAction(repeatAction);
    }
}

