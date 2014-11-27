//
//  GameScene.swift
//  Hunter
//
//  Created by George Chernov on 31/08/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    

    let appName = "SportsCat"
    let commonBoldFont = "Helvetica Neue"
    
    let backBtnTouchDuration:UInt8 = 3
    
    // size of the scene, for iPad = 768 / 1024
    var sceneSize: CGPoint = CGPoint()
    
    var gameScoreLabel = AdvancedLabel()
    var gameScore = 0
    
    var isFirstScreen = true;

    
    // first screen elements
    var bottomRight = SKSpriteNode()
    var catSport = AdvancedLabel()
    var startLabel = AdvancedLabel()
    var firstMouse = SKSpriteNode()
    var firstCat = SKSpriteNode()
    

    var backBtnCounter:UInt8 = 0
    var timer = NSTimer()
    
    var prey:Prey = Prey()
    var tempPray:Prey = Prey()
    
    var holdForSecondsTipLabel = AdvancedLabel()
    var gameNameLabel = AdvancedLabel()
    var gameBackBtn = AdvancedLabel()
    var gameBackBtnSettings = AdvancedLabel()
    
    var leftCogwheel = SKSpriteNode()
    var rightCogwheel = SKSpriteNode()
    
    var mouseScoreImg = SKSpriteNode()
    
    var labelMouseSpeedSetting = AdvancedLabel()
    
    var slowMouseSpeedSetting = SKSpriteNode()
    var middleMouseSpeedSetting = SKSpriteNode()
    var fastMouseSpeedSetting = SKSpriteNode()
    var selectedMouseSpeedSetting = SKSpriteNode()
    
    var labelBackgroundSetting = AdvancedLabel()
    
    var whiteBackgroundSetting = SKSpriteNode()
    var greenBackgroundSetting = SKSpriteNode()
    var yellowBackgroundSetting = SKSpriteNode()
    var selectedBackgroundSetting = SKSpriteNode()
    
    var background = SKSpriteNode(imageNamed: "background")
    
    override func didMoveToView(view: SKView) {
        
        sceneSize = CGPoint(x: view.bounds.size.width, y: view.bounds.size.height)
        showFirstScreen()

    }

    func showFirstScreen()
    {
        
        gameScore = 0;
        
        FlurryAnalytics.log("FirstScreen opened")
        FlurryAnalytics.timeLogStart("FirstScreen duration")
    
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
        
        leftCogwheel = SKSpriteNode(imageNamed: "cogwheelLeft")
        leftCogwheel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftCogwheel.position = CGPoint(x: 120, y: 120)
        leftCogwheel.name = "leftCogwheel"
        self.addChild(leftCogwheel)
        
        rightCogwheel = SKSpriteNode(imageNamed: "cogwheelRight")
        rightCogwheel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightCogwheel.position = CGPoint(x: 178, y: 95)
        rightCogwheel.name = "rightCogwheel"
        self.addChild(rightCogwheel)
        
        var cogwheelLeftRotation = SKAction.rotateByAngle(2, duration: 4)
        var cogwheelRightRotation = SKAction.rotateByAngle(-2, duration: 4)
        leftCogwheel.runAction(SKAction.repeatActionForever(cogwheelLeftRotation))
        rightCogwheel.runAction(SKAction.repeatActionForever(cogwheelRightRotation))
        
    }
    
    func hideFirstScreen()
    {
        
        FlurryAnalytics.timeLogStop("FirstScreen duration")
        
        var fadeAction = SKAction.fadeAlphaTo(0, duration: 0.3)
        var removeAction = SKAction.removeFromParent()
        var fadeAndRenoveSeq = SKAction.sequence([fadeAction, removeAction])
        
        bottomRight.runAction(fadeAndRenoveSeq)
        catSport.runAction(fadeAndRenoveSeq)
        startLabel.runAction(fadeAndRenoveSeq)
        firstMouse.runAction(fadeAndRenoveSeq)
        leftCogwheel.runAction(fadeAndRenoveSeq)
        rightCogwheel.runAction(fadeAndRenoveSeq)
        firstCat.runAction(fadeAndRenoveSeq)
        
        background.removeFromParent()
    }
    
    func showSecondScreen()
    {
        FlurryAnalytics.log("SecondScreen opened")
        FlurryAnalytics.timeLogStart("SecondScreen duration",
            params: ["background" : AppSettings.getBackground().description, "speed" : AppSettings.getSpeed().description])
        
        isFirstScreen = false;
        
        drawVaryBackground()
        drawGameName()
        drawScore()
        drawBackBtn()

        prey = Mouse()
        tempPray = Fly()
        
        addChild(prey)
        addChild(tempPray)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerTick"), userInfo: nil, repeats: true)
        
    }
    
    func hideSecondScreen()
    {
        FlurryAnalytics.timeLogStop("SecondScreen duration")
        
        prey.removeAllActions()
        prey.removeFromParent()
        
        tempPray.removeAllActions()
        tempPray.removeFromParent()
        
        holdForSecondsTipLabel.removeFromParent()
        gameScoreLabel.removeFromParent()
        gameNameLabel.removeFromParent()
        mouseScoreImg.removeFromParent()
        gameBackBtn.removeFromParent()
        
        background.removeFromParent()
    }
    
    func showSettingsScreen()
    {
        FlurryAnalytics.log("SettingsScreen opened")
        FlurryAnalytics.timeLogStart("SettingsScreen duration",
            params: ["background" : AppSettings.getBackground().description, "speed" : AppSettings.getSpeed().description])

        
        drawBackground()
        drawSettingTitle()
        drawBackBtnForSettings()
        
        labelMouseSpeedSetting = AdvancedLabel()
        labelMouseSpeedSetting.text = "Set Mouse speed:"
        labelMouseSpeedSetting.fontColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(165/255.0), blue: CGFloat(70/255.0), alpha: 1)
        labelMouseSpeedSetting.fontSize = 30;
        labelMouseSpeedSetting.position = CGPoint(x: 207, y: 580)
        
        labelMouseSpeedSetting.create()
        self.addChild(labelMouseSpeedSetting)
        
        slowMouseSpeedSetting = SKSpriteNode(imageNamed: "slowSpeed")
        slowMouseSpeedSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        slowMouseSpeedSetting.position = CGPoint(x: 170, y: 500)
        slowMouseSpeedSetting.name = "slowMouseSpeedSetting"
        self.addChild(slowMouseSpeedSetting)
        
        middleMouseSpeedSetting = SKSpriteNode(imageNamed: "middleSpeed")
        middleMouseSpeedSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        middleMouseSpeedSetting.position = CGPoint(x: 510, y: 500)
        middleMouseSpeedSetting.name = "middleMouseSpeedSetting"
        self.addChild(middleMouseSpeedSetting)
        
        fastMouseSpeedSetting = SKSpriteNode(imageNamed: "fastSpeed")
        fastMouseSpeedSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        fastMouseSpeedSetting.position = CGPoint(x: 850, y: 500)
        fastMouseSpeedSetting.name = "fastMouseSpeedSetting"
        self.addChild(fastMouseSpeedSetting)
        
        selectedMouseSpeedSetting = SKSpriteNode(imageNamed: "selectedOption")
        selectedMouseSpeedSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        selectedMouseSpeedSetting.name = "selectedMouseSpeedSetting"
        
        if(AppSettings.getSpeed() == 1)
        {
            selectedMouseSpeedSetting.position = CGPoint(x: 170, y: 460)
        }
        else if(AppSettings.getSpeed() == 2)
        {
            selectedMouseSpeedSetting.position = CGPoint(x: 510, y: 460)
        }
        else
        {
            selectedMouseSpeedSetting.position = CGPoint(x: 850, y: 460)
        }
        
        self.addChild(selectedMouseSpeedSetting)
        
        labelBackgroundSetting = AdvancedLabel()
        labelBackgroundSetting.text = "Set background:"
        labelBackgroundSetting.fontColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(165/255.0), blue: CGFloat(70/255.0), alpha: 1)
        labelBackgroundSetting.fontSize = 30;
        labelBackgroundSetting.position = CGPoint(x: 200, y: 340)
        
        labelBackgroundSetting.create()
        self.addChild(labelBackgroundSetting)
        
        whiteBackgroundSetting = SKSpriteNode(imageNamed: "backgroundMini1")
        whiteBackgroundSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        whiteBackgroundSetting.position = CGPoint(x: 170, y: 230)
        whiteBackgroundSetting.name = "whiteBackgroundSetting"
        self.addChild(whiteBackgroundSetting)
        
        greenBackgroundSetting = SKSpriteNode(imageNamed: "backgroundMini2")
        greenBackgroundSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        greenBackgroundSetting.position = CGPoint(x: 510, y: 230)
        greenBackgroundSetting.name = "greenBackgroundSetting"
        self.addChild(greenBackgroundSetting)
        
        yellowBackgroundSetting = SKSpriteNode(imageNamed: "backgroundMini3")
        yellowBackgroundSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        yellowBackgroundSetting.position = CGPoint(x: 850, y: 230)
        yellowBackgroundSetting.name = "yellowBackgroundSetting"
        self.addChild(yellowBackgroundSetting)

        selectedBackgroundSetting = SKSpriteNode(imageNamed: "selectedOption")
        selectedBackgroundSetting.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        selectedBackgroundSetting.name = "selectedBackgroundSetting"
        
        if(AppSettings.getBackground() == 1)
        {
            selectedBackgroundSetting.position = CGPoint(x: 170, y: 160)
        }
        else if(AppSettings.getBackground() == 2)
        {
            selectedBackgroundSetting.position = CGPoint(x: 510, y: 160)
        }
        else
        {
            selectedBackgroundSetting.position = CGPoint(x: 850, y: 160)
        }
        
        self.addChild(selectedBackgroundSetting)
    }
    
    func hideSettingsScreen()
    {
        FlurryAnalytics.timeLogStop("SettingsScreen duration",
            params: ["background" : AppSettings.getBackground().description, "speed" : AppSettings.getSpeed().description])

        
        gameNameLabel.removeFromParent()
        gameBackBtnSettings.removeFromParent()
        
        background.removeFromParent()
        
        slowMouseSpeedSetting.removeFromParent()
        middleMouseSpeedSetting.removeFromParent()
        fastMouseSpeedSetting.removeFromParent()
        selectedMouseSpeedSetting.removeFromParent()
        labelMouseSpeedSetting.removeFromParent()
        
        labelBackgroundSetting.removeFromParent()
        
        whiteBackgroundSetting.removeFromParent()
        yellowBackgroundSetting.removeFromParent()
        greenBackgroundSetting.removeFromParent()
        selectedBackgroundSetting.removeFromParent()
    }


    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            var location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            if node.name != nil
            {
                if (node.name == "prey")
                {
                    prey.preyCaught()
                    
                    gameScore++
                    changeScore()
                    
                }
                
                if (node.name == "bg")
                {
                    if(!isFirstScreen)
                    {
                        prey.failedAttemptToCatch(location)
                    }
                }
                
                if(node.name == "leftCogwheel" || node.name == "rightCogwheel")
                {
                    hideFirstScreen()
                    showSettingsScreen()
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
                    
                    FlurryAnalytics.log("Back button touched")
                }
                
                if(node.name == "backBtnSettings")
                {
                    hideSettingsScreen()
                    showFirstScreen()
                    
                    FlurryAnalytics.log("Back button settings touched")
                }
                
                if(node.name == "slowMouseSpeedSetting")
                {
                    selectedMouseSpeedSetting.position = CGPoint(x: 170, y: 460)
                    AppSettings.setSpeed(1)
                }
                
                if(node.name == "middleMouseSpeedSetting")
                {
                    selectedMouseSpeedSetting.position = CGPoint(x: 510, y: 460)
                    AppSettings.setSpeed(2)
                }
                
                if(node.name == "fastMouseSpeedSetting")
                {
                    selectedMouseSpeedSetting.position = CGPoint(x: 850, y: 460)
                    AppSettings.setSpeed(3)
                }
                
                if(node.name == "whiteBackgroundSetting")
                {
                    selectedBackgroundSetting.position = CGPoint(x: 170, y: 160)
                    AppSettings.setBackground(1)
                }
                
                if(node.name == "greenBackgroundSetting")
                {
                    selectedBackgroundSetting.position = CGPoint(x: 510, y: 160)
                    AppSettings.setBackground(2)
                }
                
                if(node.name == "yellowBackgroundSetting")
                {
                    selectedBackgroundSetting.position = CGPoint(x: 850, y: 160)
                    AppSettings.setBackground(3)
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
    
    func drawBackground()
    {
        background = SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.name = "bg"
        self.addChild(background)
    }
    
    func drawVaryBackground()
    {
        var backgroundName = ""
        
        if(AppSettings.getBackground() == 1)
        {
            backgroundName = "background"
        }
        else if(AppSettings.getBackground() == 2)
        {
            backgroundName = "background2"
        }
        else
        {
            backgroundName = "background3"
        }
        
        background = SKSpriteNode(imageNamed: backgroundName)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.name = "bg"
        self.addChild(background)
    }
    
    // show 'Mouser' at the second screen
    func drawGameName()
    {
        gameNameLabel = AdvancedLabel()
        gameNameLabel.text = appName
        gameNameLabel.fontColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(165/255.0), blue: CGFloat(70/255.0), alpha: 1)
        gameNameLabel.fontSize = 65;
        gameNameLabel.position = CGPoint(x: sceneSize.x / 2, y: sceneSize.y - 70)
        
        gameNameLabel.create()
        self.addChild(gameNameLabel)
    }
    
    func drawSettingTitle()
    {
        gameNameLabel = AdvancedLabel()
        gameNameLabel.text = "Settings"
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
        gameBackBtn.text = "Back"
        gameBackBtn.fontSize = 45;
        gameBackBtn.position = CGPoint(x: sceneSize.x / 2 - 375, y: sceneSize.y - 65)
        gameBackBtn.name = "backBtn"
        
        gameBackBtn.create()
        self.addChild(gameBackBtn)

    }
    
    func drawBackBtnForSettings()
    {
        
        gameBackBtnSettings = AdvancedLabel()
        gameBackBtnSettings.text = "Back"
        gameBackBtnSettings.fontSize = 45;
        gameBackBtnSettings.position = CGPoint(x: sceneSize.x / 2 - 375, y: sceneSize.y - 65)
        gameBackBtnSettings.name = "backBtnSettings"
        
        gameBackBtnSettings.create()
        self.addChild(gameBackBtnSettings)
        
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
        
        holdForSecondsTipLabel.changeText("Hold for " + (backBtnTouchDuration - backBtnCounter).description + " " +  ((backBtnTouchDuration - backBtnCounter) == 1 ?  "second" : "seconds"))
        
        if(backBtnCounter == backBtnTouchDuration)
        {
            resetBackBtn()
            hideSecondScreen()
            showFirstScreen()
            
            //FlurryAnalytics.log("Go back to first screen")
        }
    }
    
    func holdForSecondsTip()
    {
        holdForSecondsTipLabel = AdvancedLabel()
        holdForSecondsTipLabel.text = "Hold for " + backBtnTouchDuration.description + " seconds"
        holdForSecondsTipLabel.fontSize = 25;
        holdForSecondsTipLabel.position = CGPoint(x: sceneSize.x / 2 - 375, y: sceneSize.y - 100)

        holdForSecondsTipLabel.create()
        self.addChild(holdForSecondsTipLabel)
        
    }

}
