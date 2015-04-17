//
//  Cart.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 4/14/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Cart : SKSpriteNode {
    var velocity: CGFloat!
    var trackPos: Int!
    
    var id: Int!
    
    var horSize: CGSize!
    var topDownSize: CGSize!
    var frontSize: CGSize!
    
    var horTexture: SKTexture!
    var topDownTexture: SKTexture!
    var frontTexture: SKTexture!
    
    //Feed in the id of the cart and based on that decide on the sizes
    init(velocity: CGFloat, id: Int, scene: Int) {
        //super.init(imageNamed: imageNamed)
        var texture = SKTexture()
        self.velocity = velocity
        self.id = id
        switch id {
            case 0: // Default
                horSize = CGSize(width: 128.0, height: 96.0)
                topDownSize = CGSize(width: 96.0, height: 128.0)
                horTexture = SKTexture(imageNamed: "minecartHor")
                topDownTexture = SKTexture(imageNamed: "minecartTopDown")
            case 1:
                horSize = CGSize(width: 64.0, height: 64.0)
                topDownSize = CGSize(width: 64.0, height: 64.0)
                horTexture = SKTexture(imageNamed: "minecartHor")
                topDownTexture = SKTexture(imageNamed: "minecartTopDown")
            case 2:
                horSize = CGSize(width: 200.0, height: 300.0)
                topDownSize = CGSize(width: 96.0, height: 200.0)
                horTexture = SKTexture(imageNamed: "minecartHor")
                topDownTexture = SKTexture(imageNamed: "minecartTopDown")
            default:
                horSize = CGSize(width: 128.0, height: 96.0)
                topDownSize = CGSize(width: 300.0, height: 96.0)
                horTexture = SKTexture(imageNamed: "minecartHor")
                topDownTexture = SKTexture(imageNamed: "minecartTopDown")
        }
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