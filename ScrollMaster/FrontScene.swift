//
//  FrontScene.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 4/13/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class FrontScene : SKScene {
    var parentVC: UIViewController!
    var player: Player!
    
    override func didMoveToView(view: SKView) {
        player = Player()
        
    }
}