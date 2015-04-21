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
    init(id: Int, scene: Int) {
        //super.init(imageNamed: imageNamed)
        var texture = SKTexture()
        self.id = id
        switch id {
            case 0: // Default Cart
                horSize = CGSize(width: 128.0, height: 96.0)
                topDownSize = CGSize(width: 96.0, height: 128.0)
                horTexture = SKTexture(imageNamed: "minecartHor")
                topDownTexture = SKTexture(imageNamed: "minecartTopDown")
                velocity = 3
            case 1: // Sports Car
                horSize = CGSize(width: 128.0, height: 96.0)
                topDownSize = CGSize(width: 96.0, height: 128.0)
                horTexture = SKTexture(imageNamed: "sportsCar")
                topDownTexture = SKTexture(imageNamed: "sportsCar")
                velocity = 15
            case 2: // Big Mama
                horSize = CGSize(width: 500.0, height: 400.0)
                topDownSize = CGSize(width: 96.0, height: 500.0)
                horTexture = SKTexture(imageNamed: "minecartHor")
                topDownTexture = SKTexture(imageNamed: "minecartTopDown")
                velocity = 4
            default:
                horSize = CGSize(width: 128.0, height: 96.0)
                topDownSize = CGSize(width: 300.0, height: 96.0)
                horTexture = SKTexture(imageNamed: "minecartHor")
                topDownTexture = SKTexture(imageNamed: "minecartTopDown")
                velocity = 5
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