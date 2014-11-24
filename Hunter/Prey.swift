//
//  Prey.swift
//  SportsCat
//
//  Created by George Chernov on 01/11/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import SpriteKit
import AVFoundation

class Prey: SKSpriteNode
{
    
    var audioPlayer = AVAudioPlayer()
    
    override init() {
        
        super.init()
        
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("escapedMouse", ofType: "mp3")!)
        
        // Removed deprecated use of AVAudioSessionDelegate protocol
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.volume = 0.3
        
        audioPlayer.prepareToPlay()
        
        name = "prey"
    }
    
    override init(texture: SKTexture, color: SKColor, size: CGSize)
    {
        super.init(texture:texture, color:color, size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    func preyCaught()
    {
        fatalError("preyCaught() has to be overrided")
    }
    
    func failedAttemptToCatch(touchPosition:CGPoint)
    {
        fatalError("failedAttemptToCatch(touchPosition:CGPoint) has to be overrided")
    }
    
}
