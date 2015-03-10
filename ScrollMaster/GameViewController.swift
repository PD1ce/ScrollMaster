//
//  GameViewController.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 3/9/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        println("Height: \(view.bounds.size.height)")
        println("Width: \(view.bounds.size.width)")
        let skView = view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}