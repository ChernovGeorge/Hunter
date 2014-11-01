//
//  AdvancedLabel.swift
//  Hunter
//
//  Created by George Chernov on 28/09/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation
import SpriteKit

class AdvancedLabel: SKLabelNode
{
    var shadow = SKLabelNode()
    
    override init()
    {
        super.init()
        
        // default settings
        self.fontColor = SKColor(red: CGFloat(164/255.0), green: CGFloat(85/255.0), blue: CGFloat(164/255.0), alpha: 1)
        self.fontName = "Helvetica Neue Light"
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func changeText(newText:NSString)
    {
        self.text = newText
        shadow.text = newText
    }
    
    func create()
    {
        self.zPosition = 10
        
        shadow.text = text
        shadow.fontColor = SKColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: 0.15)
        shadow.fontSize = fontSize
        shadow.fontName = fontName
        shadow.position = CGPoint(x: 1, y: 0)
        
        shadow.zPosition = -1
        
        self.addChild(shadow)
    }
    
}
