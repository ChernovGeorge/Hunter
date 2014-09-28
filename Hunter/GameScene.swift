//
//  GameScene.swift
//  Hunter
//
//  Created by George Chernov on 31/08/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    // size of the scene, for iPad = 768 / 1024
    var sceneSize: CGPoint = CGPoint()
    let textureAtlas = SKTextureAtlas(named:"mouse.atlas")
    
    var gameScoreLabel = AdvancedLabel()
    var gameScore = 0

    var spriteArray = Array<SKTexture>()
    
    var repeatAction = SKAction()
    var animateAction = SKAction()
    
    var audioPlayer = AVAudioPlayer()
    
    var isFirstScreen = true;
    
    // the location of the hole, the place where the mouse go from
    let holeLocation = CGPoint(x: 1200, y: 600)
    let appName = "Sport Cat"
    let commonFont = "Helvetica Neue Light"
    let commonBoldFont = "Helvetica Neue"
    
    
    // first screen elements
    
    var bottomRight = SKSpriteNode()
    var catSport = AdvancedLabel()
    var startLabel = AdvancedLabel()
    var firstMouse = SKSpriteNode()
    var firstCat = SKSpriteNode()
    
    // end block
    
    var backBtnCounter:UInt8 = 0
    var timer = NSTimer()
    
    var holdForSecondsTipLabel = AdvancedLabel()
    
    let backBtnTouchDuration:UInt8 = 3
    
    var mouse = SKSpriteNode()
    
    var gameNameLabel = AdvancedLabel()
    
    var mouseScoreImg = SKSpriteNode()
    
    var gameBackBtn = AdvancedLabel()
    
    override func didMoveToView(view: SKView) {
        
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("escapedMouse", ofType: "mp3")!)
        
        // Removed deprecated use of AVAudioSessionDelegate protocol
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.volume = 0.3
        
        sceneSize = CGPoint(x: view.bounds.size.width, y: view.bounds.size.height)
        showFirstScreen()
        //showSecondScreen()
    }
    
    func showFirstScreen()
    {
    
        isFirstScreen = true;
        
        drawBackground()
        
        self.backgroundColor = SKColor.whiteColor()
        
        bottomRight = SKSpriteNode(imageNamed: "bottomRightCorner")
        bottomRight.anchorPoint = CGPoint(x: 1, y: 0)
        bottomRight.position = CGPoint(x: sceneSize.x, y: 0)
        bottomRight.name = "bottomRight"
        self.addChild(bottomRight)
        
        
        catSport = AdvancedLabel()
        catSport.text = appName
        catSport.fontSize = 90;
        catSport.position = CGPoint(x: 640, y: 570)
        
        catSport.create()
        self.addChild(catSport)
        
        
        startLabel = AdvancedLabel()
        startLabel.text = "START"
        startLabel.fontColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(165/255.0), blue: CGFloat(70/255.0), alpha: 1)
        startLabel.fontSize = 80;
        startLabel.position = CGPoint(x: 640, y: 390)
        startLabel.name = "startLabel"

        startLabel.create()
        self.addChild(startLabel)
        
        firstMouse = SKSpriteNode(imageNamed: "mouseOrigamiBig")
        firstMouse.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        firstMouse.position = CGPoint(x: sceneSize.y - 117, y: 175)
        firstMouse.name = "firstMouse"
        self.addChild(firstMouse)
        
        firstCat = SKSpriteNode(imageNamed: "catOrigami")
        firstCat.anchorPoint = CGPoint(x: 0, y: 1)
        firstCat.position = CGPoint(x: 0, y: sceneSize.y)
        firstCat.name = "firstCat"
        self.addChild(firstCat)
        
        var increaseStart = SKAction.scaleTo(1.03, duration: 0.2)
        var reduceStart = SKAction.scaleTo(0.97, duration: 0.6)
        
        var sequence = SKAction.sequence([increaseStart, reduceStart])
        
        startLabel.runAction(SKAction.repeatActionForever(sequence))
        
    }
    
    func hideFirstScreen()
    {
        
        var fadeAction = SKAction.fadeAlphaTo(0, duration: 0.3)
        var removeAction = SKAction.removeFromParent()
        var fadeAndRenoveSeq = SKAction.sequence([fadeAction, removeAction])
        
        bottomRight.runAction(fadeAndRenoveSeq)
        catSport.runAction(fadeAndRenoveSeq)
        startLabel.runAction(fadeAndRenoveSeq)
        firstMouse.runAction(fadeAndRenoveSeq)
        firstCat.runAction(fadeAndRenoveSeq)
    }
    
    func showSecondScreen()
    {
        
        drawBackground()
        drawGameName()
        drawScore()
        drawBackBtn()
        
        spriteArray.append(textureAtlas.textureNamed("M1"))
        spriteArray.append(textureAtlas.textureNamed("M2"))
        spriteArray.append(textureAtlas.textureNamed("M3"))
        spriteArray.append(textureAtlas.textureNamed("M4"))
        spriteArray.append(textureAtlas.textureNamed("M5"))
        spriteArray.append(textureAtlas.textureNamed("M6"))
        spriteArray.append(textureAtlas.textureNamed("M7"))
        spriteArray.append(textureAtlas.textureNamed("M8"))
        
        mouse = SKSpriteNode(texture:spriteArray[0])
        mouse.position = CGPoint(x: 200, y: 200)
        mouse.name = "mouse"
        
        
        self.addChild(mouse)
        
        
        animateAction = SKAction.animateWithTextures(spriteArray, timePerFrame: 0.10);
        repeatAction = SKAction.repeatActionForever(animateAction);
        mouse.runAction(repeatAction);
        
        startMoving()
    }
    
    func hideSecondScreen()
    {
        mouse.removeAllActions()
        mouse.removeFromParent()
        
        holdForSecondsTipLabel.removeFromParent()
        gameScoreLabel.removeFromParent()
        gameNameLabel.removeFromParent()
        mouseScoreImg.removeFromParent()
        gameBackBtn.removeFromParent()
    }
    
    func getDuration() -> NSTimeInterval
    {
        var limitedRandom:Int32 = Int32(arc4random() % UInt32(5));
        return NSTimeInterval((limitedRandom < 2) ? (limitedRandom + 2): limitedRandom);
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
    
    
    // is user touch close to mouse
    // TODO: change the logic of distanse calculation, use sqrt in order to find the distanse
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
    

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            var location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            if node.name != nil
            {
                if (node.name == "mouse")
                {
                    mouseCaughtEffectPlay()
                    
                    gameScore++
                    changeScore()
                }
                
                if (node.name == "bg")
                {
                    if(!isFirstScreen)
                    {
                        // TODO: to investigate: use runAction:withKey, it removes the existing action automaticaly
                        self.childNodeWithName("mouse")?.removeAllActions()
                    
                        var pathwayCreator = PathwayCreator(startPoint: holeLocation, countOfPathes: 8)
                        var bp:UIBezierPath = pathwayCreator.GetPath()
                    
                        var mousePosition = self.childNodeWithName("mouse")?.position;
                    
                        if(isTouchCloseToMouse(mousePosition!, touchPosition:location))
                        {
                            mouseEscapedEffectPlay()
                        }
                    
                        var pathBackToHole = CGPathCreateMutable();
                        CGPathMoveToPoint(pathBackToHole, nil, (mousePosition?)!.x, (mousePosition?)!.y)
                        CGPathAddLineToPoint(pathBackToHole, nil, holeLocation.x, holeLocation.y)
                    
                        // TODO: maybe it will be suitable to use constant speed of the mouse during path, 
                        // to get it I have to calculate the duration
                        // it can make the mouse movement more natural
                        var act1 = SKAction.followPath(pathBackToHole, asOffset: false, orientToPath: true, duration: 0.3)
                        var act2 = SKAction.followPath(bp.CGPath, asOffset:false, orientToPath:true, duration: getDuration());
                    
                        var sequence = SKAction.sequence([act1, act2])
                    
                        self.childNodeWithName("mouse")?.runAction(repeatAction)
                        self.childNodeWithName("mouse")?.runAction(sequence, startMoving)
                    }
                }
                
                if(node.name == "startLabel")
                {
                    hideFirstScreen()
                    showSecondScreen()
                }
                
                if(node.name == "backBtn")
                {
                    holdForSecondsTip()
                    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerTick"), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        resetBackBtn()
    }
    
    func resetBackBtn()
    {
        timer.invalidate()
        backBtnCounter = 0;
        
        holdForSecondsTipLabel.removeFromParent()
    }
    
    func mouseEscapedEffectPlay()
    {
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func mouseCaughtEffectPlay()
    {
        self.runAction(SKAction.playSoundFileNamed("caughtMouse.mp3", waitForCompletion: false))
    }
    
    func drawBackground()
    {
        var background = SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.name = "bg"
        self.addChild(background)
    }
    
    // show 'Mouser' at the second screen
    func drawGameName()
    {
        gameNameLabel = AdvancedLabel()
        gameNameLabel.text = "SPORT CAT"
        gameNameLabel.fontColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(165/255.0), blue: CGFloat(70/255.0), alpha: 1)
        gameNameLabel.fontSize = 65;
        gameNameLabel.position = CGPoint(x: sceneSize.x / 2, y: sceneSize.y - 70)
        
        gameNameLabel.create()
        self.addChild(gameNameLabel)
    }
    
    func drawScore()
    {
        
        gameScoreLabel = AdvancedLabel()
        gameScoreLabel.text = "0000"
        gameScoreLabel.fontSize = 45
        gameScoreLabel.position = CGPoint(x: sceneSize.x / 2 + 390, y: sceneSize.y - 65)
        
        gameScoreLabel.create()
        self.addChild(gameScoreLabel)
        
        mouseScoreImg = SKSpriteNode(imageNamed: "mouseScore");
        mouseScoreImg.anchorPoint = CGPoint(x: 0, y: 0)
        mouseScoreImg.position = CGPoint(x: sceneSize.x / 2 + 270, y: sceneSize.y - 66)
        mouseScoreImg.zPosition = 10
        
        self.addChild(mouseScoreImg)
    }
    
    func drawBackBtn()
    {
        
        gameBackBtn = AdvancedLabel()
        gameBackBtn.text = "BACK"
        gameBackBtn.fontSize = 45;
        gameBackBtn.position = CGPoint(x: sceneSize.x / 2 - 375, y: sceneSize.y - 65)
        gameBackBtn.name = "backBtn"
        
        gameBackBtn.create()
        self.addChild(gameBackBtn)

    }
    
    func changeScore()
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
            
            gameScoreLabel.position = CGPoint(x: sceneSize.x / 2 + 395, y: sceneSize.y - 60)
        }
        
        gameScoreLabel.changeText(score)
    }
    
    func timerTick()
    {
        backBtnCounter++
        
        holdForSecondsTipLabel.changeText("Hold For " + (backBtnTouchDuration - backBtnCounter).description + " Seconds")
        
        if(backBtnCounter == backBtnTouchDuration)
        {
            resetBackBtn()
            hideSecondScreen()
            showFirstScreen()
        }
    }
    
    func holdForSecondsTip()
    {
        holdForSecondsTipLabel = AdvancedLabel()
        holdForSecondsTipLabel.text = "Hold For " + backBtnTouchDuration.description + " Seconds"
        holdForSecondsTipLabel.fontSize = 25;
        holdForSecondsTipLabel.position = CGPoint(x: sceneSize.x / 2 - 375, y: sceneSize.y - 100)

        holdForSecondsTipLabel.create()
        self.addChild(holdForSecondsTipLabel)
        
    }

}
