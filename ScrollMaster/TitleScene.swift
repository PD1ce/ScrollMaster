//
//  TitleScene.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 4/20/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class TitleScene : SKScene {
    var player: Player!
    var parentVC: UIViewController!
    
    var storyModeButton: UIButton!
    var endlessModeButton: UIButton!
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor(red: 0.3, green: 0.738, blue: 0.2, alpha: 1.0)
        
        storyModeButton = UIButton(frame: CGRect(x: 50, y: 50, width: self.view!.frame.width / 2 - 75, height: self.view!.frame.height - 100))
        storyModeButton.addTarget(self, action: "storyModeTapped", forControlEvents: .TouchUpInside)
        storyModeButton.backgroundColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        storyModeButton.setTitle("Story", forState: .Normal)
        storyModeButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        storyModeButton.layer.cornerRadius = 10.0
        storyModeButton.layer.borderWidth = 5.0
        storyModeButton.layer.borderColor = UIColor(white: 0.0, alpha: 1.0).CGColor
        endlessModeButton = UIButton(frame: CGRect(x: 50 + storyModeButton.frame.width + 50, y: 50, width: self.view!.frame.width / 2 - 75, height: self.view!.frame.height - 100))
        endlessModeButton.addTarget(self, action: "endlessModeTapped", forControlEvents: .TouchUpInside)
        endlessModeButton.backgroundColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        endlessModeButton.setTitle("Endless", forState: .Normal)
        endlessModeButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        endlessModeButton.layer.cornerRadius = 10.0
        endlessModeButton.layer.borderWidth = 5.0
        endlessModeButton.layer.borderColor = UIColor(white: 0.0, alpha: 1.0).CGColor
        
        self.view?.addSubview(storyModeButton)
        self.view?.addSubview(endlessModeButton)
    }
    
    func storyModeTapped() {
        let player = Player()
        let horScene = HorizontalScene(size: parentVC.view.bounds.size)
        
        horScene.player = player
        horScene.parentVC = parentVC
        horScene.timeToNextCart = 60
        horScene.timeToNextViewCrystal = 200
        horScene.scaleMode = .ResizeFill
        
        storyModeButton.removeFromSuperview()
        endlessModeButton.removeFromSuperview()
        
        //self.view?.presentScene(horScene)
        self.view?.presentScene(horScene, transition: SKTransition.doorsOpenHorizontalWithDuration(1.0))
    }
    func endlessModeTapped() {
        let player = Player()
        let horScene = HorizontalScene(size: parentVC.view.bounds.size)
        
        horScene.player = player
        horScene.parentVC = parentVC
        horScene.timeToNextCart = 60
        horScene.timeToNextViewCrystal = 200
        horScene.scaleMode = .ResizeFill
        
        storyModeButton.removeFromSuperview()
        endlessModeButton.removeFromSuperview()
        
        self.view?.presentScene(horScene)
    }
    
}