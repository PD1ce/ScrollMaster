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
    
    var startButton: UIButton!
    var skView: SKView!
    var horScene: HorizontalScene!
    var vertScene: TopDownScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Why load this?
        //horScene = HorizontalScene(size: view.bounds.size)
        //vertScene = TopDownScene(size: view.bounds.size)
        
        println("Height: \(view.bounds.size.height)")
        println("Width: \(view.bounds.size.width)")
        skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        //horScene.scaleMode = .ResizeFill
        //vertScene.scaleMode = .ResizeFill


        /*
        var timeToNextCart: Int = 60
        var timeToNextViewCrystal: Int = 200
        let player = Player()
        player.pos = 2
        horScene.player = player
        horScene.timeToNextCart = timeToNextCart
        horScene.timeToNextViewCrystal = timeToNextViewCrystal
        horScene.parentVC = self
        skView.presentScene(horScene)
        */
        let titleScene = TitleScene(size: view.bounds.size)
        titleScene.parentVC = self
        skView.presentScene(titleScene)
    }
    
    func startButtonTapped() {
        startButton.hidden = true
        skView.presentScene(horScene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}