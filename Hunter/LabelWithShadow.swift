//
//  LabelWithShadow.swift
//  Hunter
//
//  Created by George Chernov on 24/09/14.
//  Copyright (c) 2014 georgechernov. All rights reserved.
//

import Foundation
import SpriteKit

class LabelWithShadow
{
    init(){
        
    }
    
    func getLabelWithShadow(label: SKLabelNode) -> SKLabelNode
    {
        var newLabel = SKLabelNode()
        newLabel.text = label.text
        newLabel.fontColor = SKColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: 0.15)
        newLabel.fontSize = label.fontSize
        newLabel.fontName = label.fontName
        newLabel.position = CGPoint(x: label.position.x + 1, y: label.position.y - 1)
        
        return newLabel;
    }
    
    
}

