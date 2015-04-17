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
        horScene = HorizontalScene(size: view.bounds.size)
        vertScene = TopDownScene(size: view.bounds.size)
        println("Height: \(view.bounds.size.height)")
        println("Width: \(view.bounds.size.width)")
        skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        horScene.scaleMode = .ResizeFill
        vertScene.scaleMode = .ResizeFill
        /*
        skView.backgroundColor = UIColor(red: 0.3, green: 0.738, blue: 0.2, alpha: 1.0)
        view.backgroundColor = UIColor(red: 0.3, green: 0.738, blue: 0.2, alpha: 1.0)
        startButton = UIButton(frame: CGRect(x: 412, y: 334, width: 200, height: 100))
        startButton.titleLabel?.text = "Start!"
        startButton.titleLabel?.font = UIFont(name: "Futura", size: 40.0)
        
        startButton.addTarget(self, action: "startButtonTapped", forControlEvents: .TouchUpInside)
        skView.addSubview(startButton)
        view.addSubview(startButton)
        */
        //skView.presentScene(horScene)
        var timeToNextCart: Int = 30
        var timeToNextViewCrystal: Int = 100
        let player = Player()
        player.pos = 2
        horScene.player = player
        horScene.timeToNextCart = timeToNextCart
        horScene.timeToNextViewCrystal = timeToNextViewCrystal
        horScene.parentVC = self
        skView.presentScene(horScene)
    }
    
    func startButtonTapped() {
        startButton.hidden = true
        skView.presentScene(horScene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}