//
//  Player.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 4/10/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Player : SKSpriteNode {
    var pos: Int!
    var horizontalGems: Int!
    var topDownGems: Int!
    var frontGems: Int!
    var bonusGems: Int!
    
    init() {
        //super.init(imageNamed: imageNamed)
        let texture = SKTexture(imageNamed: "playerCar")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        pos = 2
        self.zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}