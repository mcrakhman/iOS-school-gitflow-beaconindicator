//
//  AccuracyScene.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import Foundation
import SpriteKit

class AccuracyScene: SKScene {
    
    var accuracyNode: SKLabelNode
    
    var accuracy: Double = 0 {
        didSet {
            accuracyNode.text = "Accuracy: \(accuracy) meters"
        }
    }
    
    override init(size: CGSize) {
        accuracyNode = SKLabelNode(text: "Accuracy: 0")
        accuracyNode.fontSize = 24.0
        accuracyNode.fontColor = UIColor.white
        accuracyNode.position = CGPoint(x: size.width / 2.0, y: 10.0)
        accuracyNode.fontName = "HelveticaNeue"
        super.init(size: size)
        
        backgroundColor = UIColor.clear
        addChild(accuracyNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
