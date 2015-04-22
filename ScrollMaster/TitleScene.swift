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
        for sub in view.subviews {
            sub.removeFromSuperview()
        }
        
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
        horScene.score = 0
        
        let topBar = UIView(frame: CGRect(x: 0, y: 0, width: parentVC.view.frame.width, height: parentVC.view.frame.height * 0.075))
        topBar.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: topBar.frame.width * 0.2, height: topBar.frame.height))
        menuButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        menuButton.setTitle("Menu", forState: .Normal)
        menuButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24.0)
        let scoreLabel = UILabel(frame: CGRect(x: topBar.frame.width * 0.3, y: 0, width: topBar.frame.width * 0.4, height: topBar.frame.height))
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        scoreLabel.font = UIFont(name: "Helvetica", size: 24.0)
        let optionsButton = UIButton(frame: CGRect(x: topBar.frame.width * 0.8, y: 0, width: topBar.frame.width * 0.2, height: topBar.frame.height))
        optionsButton.setTitle("Options", forState: .Normal)
        optionsButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        optionsButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24.0)
        
        let bottomBar = UIView(frame: CGRect(x: 0, y: parentVC.view.frame.height * 0.925, width: parentVC.view.frame.width, height: parentVC.view.frame.height * 0.075))
        bottomBar.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        let horCrystalImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        horCrystalImage.image = UIImage(named: "horCrystal")
        horCrystalImage.userInteractionEnabled = true
        let horCrystalLabel = UILabel(frame: CGRect(x: bottomBar.frame.width * 0.1, y: 0, width: bottomBar.frame.width * 0.1, height: bottomBar.frame.height))
        horCrystalLabel.font = UIFont(name: "Helvetica", size: 24.0)
        horCrystalLabel.textAlignment = NSTextAlignment.Center
        let topDownCrystalImage = UIImageView(frame: CGRect(x: bottomBar.frame.width * 0.4, y: 0, width: 64, height: 64))
        topDownCrystalImage.image = UIImage(named: "topDownCrystal")
        topDownCrystalImage.userInteractionEnabled = true
        let topDownCrystalLabel = UILabel(frame: CGRect(x: bottomBar.frame.width * 0.5, y: 0, width: bottomBar.frame.width * 0.1, height: bottomBar.frame.height))
        topDownCrystalLabel.font = UIFont(name: "Helvetica", size: 24.0)
        topDownCrystalLabel.textAlignment = NSTextAlignment.Center
        let frontCrystalImage = UIImageView(frame: CGRect(x: bottomBar.frame.width * 0.8, y: 0, width: 64, height: 64))
        frontCrystalImage.image = UIImage(named: "frontCrystal")
        frontCrystalImage.userInteractionEnabled = true
        let frontCrystalLabel = UILabel(frame: CGRect(x: bottomBar.frame.width * 0.9, y: 0, width: bottomBar.frame.width * 0.1, height: bottomBar.frame.height))
        frontCrystalLabel.font = UIFont(name: "Helvetica", size: 24.0)
        frontCrystalLabel.textAlignment = NSTextAlignment.Center
        
        horScene.topBar = topBar
        horScene.menuButton = menuButton
        horScene.scoreLabel = scoreLabel
        horScene.optionsButton = optionsButton
       // topBar.addSubview(menuButton)
       // topBar.addSubview(scoreLabel)
        //topBar.addSubview(optionsButton)
        
        //bottomBar.addSubview(horCrystalImage)
        
        //horScene.view?.addSubview(topBar)
        
        horScene.bottomBar = bottomBar
        horScene.horCrystalImage = horCrystalImage
        horScene.horCrystalLabel = horCrystalLabel
        horScene.topDownCrystalImage = topDownCrystalImage
        horScene.topDownCrystalLabel = topDownCrystalLabel
        horScene.frontCrystalImage = frontCrystalImage
        horScene.frontCrystalLabel = frontCrystalLabel
        
        horScene.invincibilityTime = 0
        horScene.horCrystals = 10
        horScene.topDownCrystals = 10
        horScene.frontCrystals = 10
        
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
        horScene.score = 0
        
        storyModeButton.removeFromSuperview()
        endlessModeButton.removeFromSuperview()
        
        self.view?.presentScene(horScene)
    }
    
}