//
//  GameScene.swift
//  Hunter
//
//  Created by George Chernov on 31/08/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // size of the scene, for iPad = 768 / 1024
    var sceneSize: CGPoint = CGPoint()
    let textureAtlas = SKTextureAtlas(named:"mouse.atlas")
    
    var gameScoreLabel = SKLabelNode();
    var gameScoreLabelShadow = SKLabelNode();
    var gameScore = 0;
    
    var spriteArray = Array<SKTexture>();
    
    var repeatAction = SKAction();
    var animateAction = SKAction();
    
    override func didMoveToView(view: SKView) {
        
        sceneSize = CGPoint(x: view.bounds.size.width, y: view.bounds.size.height)
        //showFirstScreen()
        showSecondScreen()
    }
    
    func showFirstScreen()
    {
        drawBackgroundFirst()
        
        self.backgroundColor = SKColor.whiteColor()
        
        var bottomRight = SKSpriteNode(imageNamed: "bottomRight")
        bottomRight.anchorPoint = CGPoint(x: 1, y: 0)
        bottomRight.position = CGPoint(x: sceneSize.x, y: 0)
        //bottomRight.size = CGSize(width: sceneSize.x - 100, height: sceneSize.y - 100)
        bottomRight.name = "bottomRight"
        self.addChild(bottomRight)
        
        //var labelStart = SKLabelNode()
        
        //labelStart.text = "START"
        
        //bottomRight.anchorPoint = CGPoint(x: 1, y: 0)
        //bottomRight.position = CGPoint(x: sceneSize.x, y: 0)
        //bottomRight.size = CGSize(width: sceneSize.x - 100, height: sceneSize.y - 100)
        //bottomRight.name = "bottomRight"
        //self.addChild(bottomRight)
        
        var firstMouse = SKSpriteNode(imageNamed: "firstMouse")
        firstMouse.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        firstMouse.position = CGPoint(x: sceneSize.y - 300, y: 250)
        //bottomRight.size = CGSize(width: sceneSize.x - 100, height: sceneSize.y - 100)
        firstMouse.name = "firstMouse"
        self.addChild(firstMouse)
        
        var firstCat = SKSpriteNode(imageNamed: "firstCat")
        firstCat.anchorPoint = CGPoint(x: 0, y: 1)
        firstCat.position = CGPoint(x: 0, y: sceneSize.y)
        firstCat.name = "firstCat"
        self.addChild(firstCat)
    }
    
    func showSecondScreen()
    {
        drawBackground()
        drawGameName()
        drawScore()
        
        spriteArray.append(textureAtlas.textureNamed("M1"))
        spriteArray.append(textureAtlas.textureNamed("M2"))
        spriteArray.append(textureAtlas.textureNamed("M3"))
        spriteArray.append(textureAtlas.textureNamed("M4"))
        spriteArray.append(textureAtlas.textureNamed("M5"))
        spriteArray.append(textureAtlas.textureNamed("M6"))
        spriteArray.append(textureAtlas.textureNamed("M7"))
        
        var mouse = SKSpriteNode(texture:spriteArray[0])
        mouse.position = CGPoint(x: 200, y: 200)
        mouse.name = "mouse"
        
        
        self.addChild(mouse)
        
        
        animateAction = SKAction.animateWithTextures(spriteArray, timePerFrame: 0.10);
        repeatAction = SKAction.repeatActionForever(animateAction);
        mouse.runAction(repeatAction);
        
        startMoving()
    }
    
    func getDuration() -> NSTimeInterval
    {
        var limitedRandom:Int32 = Int32(arc4random() % UInt32(7));
        return NSTimeInterval((limitedRandom < 3) ? (limitedRandom + 3): limitedRandom);
    }
    
    func startMoving()
    {
        var pathwayCreator = PathwayCreator(startPoint: CGPoint(x: 1000, y: 600), countOfPathes: 8)
        var bp:UIBezierPath = pathwayCreator.GetPath()
        
        var duration = getDuration()
        println("d = " + duration.description)
        
        var act = SKAction.followPath(bp.CGPath, asOffset:false, orientToPath:true, duration: duration);
        self.childNodeWithName("mouse")?.runAction(act, startMoving)
    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            var location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            println(node.name)
            
            if node.name != nil
            {
                if (node.name == "mouse")
                {
                    gameScore++
                    showScore()
                }
                
                if (node.name == "bg")
                {
                    self.childNodeWithName("mouse")?.removeAllActions()
                    
                    var pathwayCreator = PathwayCreator(startPoint: CGPoint(x: 1000, y: 600), countOfPathes: 8)
                    var bp:UIBezierPath = pathwayCreator.GetPath()
                    
                    
                    var mousePosition = self.childNodeWithName("mouse")?.position;
                    
                    var pathBackToHole = CGPathCreateMutable();
                    CGPathMoveToPoint(pathBackToHole, nil, (mousePosition?)!.x, (mousePosition?)!.y)
                    CGPathAddLineToPoint(pathBackToHole, nil, 1000, 600)
                    
                    var act1 = SKAction.followPath(pathBackToHole, asOffset: false, orientToPath: true, duration: 0.8)
                    var act2 = SKAction.followPath(bp.CGPath, asOffset:false, orientToPath:true, duration: getDuration());
                    
                    var seq = SKAction.sequence([act1, act2])
                    
                    
                    self.childNodeWithName("mouse")?.runAction(repeatAction)
                    self.childNodeWithName("mouse")?.runAction(seq, startMoving)
                    
                }
            }
        }
    }
    
    func drawBackground()
    {
        var background = SKSpriteNode(imageNamed: "gameBackground")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        //background.size = CGSize(width: sceneSize.x, height: sceneSize.y)
        background.name = "bg"
        self.addChild(background)
    }
    
    // show 'Mouser' at the second screen
    func drawGameName()
    {
        
        var gameNameLabelShadow = SKLabelNode();
        gameNameLabelShadow.fontColor = SKColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: 0.15)
        gameNameLabelShadow.text = "Mouser"
        gameNameLabelShadow.fontSize = 60;
        gameNameLabelShadow.fontName = "Helvetica Neue"
        gameNameLabelShadow.position = CGPoint(x: sceneSize.x / 2 + 1, y: sceneSize.y - 61)
        gameNameLabelShadow.zPosition = 10;
        
        self.addChild(gameNameLabelShadow)
        
        var gameNameLabel = SKLabelNode();
        gameNameLabel.fontColor = SKColor(red: CGFloat(164/255.0), green: CGFloat(85/255.0), blue: CGFloat(164/255.0), alpha: 1)
        gameNameLabel.text = "Mouser"
        gameNameLabel.fontSize = 60;
        gameNameLabel.fontName = "Helvetica Neue"
        gameNameLabel.position = CGPoint(x: sceneSize.x / 2, y: sceneSize.y - 60)
        gameNameLabel.zPosition = 10;
        
        self.addChild(gameNameLabel)
    }
    
    func drawScore()
    {
        gameScoreLabelShadow = SKLabelNode();
        gameScoreLabelShadow.fontColor = SKColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: 0.15)
        gameScoreLabelShadow.text = "0000"
        gameScoreLabelShadow.fontSize = 50;
        gameScoreLabelShadow.fontName = "Helvetica Neue"
        gameScoreLabelShadow.position = CGPoint(x: sceneSize.x / 2 + 371, y: sceneSize.y - 61)
        gameScoreLabelShadow.zPosition = 10;
        
        self.addChild(gameScoreLabelShadow)
        
        gameScoreLabel = SKLabelNode();
        gameScoreLabel.fontColor = SKColor(red: CGFloat(164/255.0), green: CGFloat(85/255.0), blue: CGFloat(164/255.0), alpha: 1)
        gameScoreLabel.text = "0000"
        gameScoreLabel.fontSize = 50;
        gameScoreLabel.fontName = "Helvetica Neue"
        gameScoreLabel.position = CGPoint(x: sceneSize.x / 2 + 370, y: sceneSize.y - 60)
        gameScoreLabel.zPosition = 10;
        
        self.addChild(gameScoreLabel)
        
        var mouseScoreImg = SKSpriteNode(imageNamed: "mouseScore");
        mouseScoreImg.anchorPoint = CGPoint(x: 0, y: 0)
        mouseScoreImg.position = CGPoint(x: sceneSize.x / 2 + 250, y: sceneSize.y - 61)
        mouseScoreImg.zPosition = 10;
        
        self.addChild(mouseScoreImg)
    }
    
    func showScore()
    {
        var countOfDigits = countElements(gameScore.description)
        var score = "";
        
        
        if(countOfDigits == 1)
        {
            score =  "000" + gameScore.description
        }
        
        if(countOfDigits == 2)
        {
            score = "00" + gameScore.description
        }
        
        if(countOfDigits == 3)
        {
            score =  "0" + gameScore.description
        }
        
        if(countOfDigits == 4)
        {
            score = gameScore.description
        }
        
        if(countOfDigits > 4)
        {
            score = "Too Much!"
            gameScoreLabel.fontSize = 35
            gameScoreLabelShadow.fontSize = 35
            
            gameScoreLabelShadow.position = CGPoint(x: sceneSize.x / 2 + 396, y: sceneSize.y - 61)
            gameScoreLabel.position = CGPoint(x: sceneSize.x / 2 + 395, y: sceneSize.y - 60)
        }
        
        gameScoreLabel.text = score
        gameScoreLabelShadow.text = score
    }
    
    func drawBackgroundFirst()
    {
        var background = SKSpriteNode(imageNamed: "bgFirst")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: sceneSize.x, height: sceneSize.y)
        background.name = "bgFirst"
        self.addChild(background)
    }

}
