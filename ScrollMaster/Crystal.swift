//
//  Crystal.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 4/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class Crystal : SKSpriteNode {
    var velocity: CGFloat!
    var trackPos: Int!
    
    var id: Int!
    
    var horSize: CGSize!
    var topDownSize: CGSize!
    var frontSize: CGSize!
    
    var horTexture: SKTexture!
    var topDownTexture: SKTexture!
    var frontTexture: SKTexture!
    
    init(velocity: CGFloat, id: Int, scene: Int) {
        //super.init(imageNamed: imageNamed)
        var texture = SKTexture()
        self.velocity = velocity
        self.id = id
        
        horSize = CGSize(width: 64, height: 64)
        topDownSize = CGSize(width: 64, height: 64)
        frontSize = CGSize(width: 64, height: 64)
        horTexture = SKTexture(imageNamed: "viewCrystal")
        topDownTexture = SKTexture(imageNamed: "viewCrystal")
        frontTexture = SKTexture(imageNamed: "viewCrystal")
        
        switch scene {
            case 0:
                texture = horTexture
            case 1:
                texture = topDownTexture
            case 2:
                texture = frontTexture
            default:
                texture = horTexture
        }
        // May want to edit this size param
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}