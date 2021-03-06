//
//  TopDownScene.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 3/10/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

//PDAlert: Perhaps the scense should be created one time only and then a reference kept to each
class TopDownScene: SKScene {
    
    var parentVC: UIViewController!
    var player: Player!
    var tracks: NSMutableArray!
    var carts: NSMutableArray!
    var crystals: NSMutableArray!
    let verticalPositions = [CGFloat(256.0), CGFloat(384.0), CGFloat(512.0), CGFloat(640.0), CGFloat(768.0)] //Track 0, 1, 2, 3, 4
    var tempSwitchButton: UIButton!
    var timeToNextCart = Int()
    var timeToNextViewCrystal = Int()
    
    var gameOver: Bool = false
    var score = Int()
    
    var invincibilityTime = Int()
    var invincibleFlag: Bool = false
    
    var horCrystals = Int()
    var topDownCrystals = Int()
    var frontCrystals = Int()
    
    var topBar: UIView!
    var menuButton: UIButton!
    var scoreLabel: UILabel!
    var optionsButton: UIButton!
    
    var bottomBar: UIView!
    var horCrystalImage: UIImageView!
    var horCrystalLabel: UILabel!
    var topDownCrystalImage: UIImageView!
    var topDownCrystalLabel: UILabel!
    var frontCrystalImage: UIImageView!
    var frontCrystalLabel: UILabel!
    
    var firstTimeFlag = true
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        ///// Setup for top and bottom bars /////
        topBar.addSubview(menuButton)
        scoreLabel.text = "Score: \(score)"
        topBar.addSubview(scoreLabel)
        topBar.addSubview(optionsButton)
        view.addSubview(topBar)
        
        let horCrystalGR = UITapGestureRecognizer(target: self, action: "horCrystalTapped")
        horCrystalImage.addGestureRecognizer(horCrystalGR)
        bottomBar.addSubview(horCrystalImage)
        horCrystalLabel.text = "x \(horCrystals)"
        bottomBar.addSubview(horCrystalLabel)
        let topDownCrystalGR = UITapGestureRecognizer(target: self, action: "topDownCrystalTapped")
        topDownCrystalImage.addGestureRecognizer(topDownCrystalGR)
        bottomBar.addSubview(topDownCrystalImage)
        topDownCrystalLabel.text = "x \(topDownCrystals)"
        bottomBar.addSubview(topDownCrystalLabel)
        let frontCrystalGR = UITapGestureRecognizer(target: self, action: "frontCrystalTapped")
        frontCrystalImage.addGestureRecognizer(frontCrystalGR)
        bottomBar.addSubview(frontCrystalImage)
        frontCrystalLabel.text = "x \(frontCrystals)"
        bottomBar.addSubview(frontCrystalLabel)
        view.addSubview(bottomBar)
        
        
        
        
        /////////////////////////////////////////
        
        userInteractionEnabled = true
        tracks = NSMutableArray()
        for var i = 0; i < 5; i++ {
            let track = SKSpriteNode(color: UIColor(red: 0.644, green: 0.164, blue: 0.164, alpha: 1.0), size: CGSize(width: 32.0, height: self.frame.width))
            let realX = CGFloat((i + 1) * 128 + 128)
            track.position = CGPoint(x: realX, y: CGRectGetMidY(self.frame))
            println("Track \(i) X: \(track.position.x), Track \(i) Y: \(track.position.y)")
            track.zPosition = -2
            self.addChild(track)
            tracks.addObject(track)
        }
        
        // New carts should likely be created and replace those in carts because the sprite will change
        // Or just change texture/size?
        for cart in carts {
            //PDAlert: Use setTexture with size
            let thisCart = cart as! Cart
            thisCart.size = thisCart.topDownSize
            thisCart.texture = thisCart.topDownTexture
            println("trackPos : \(thisCart.trackPos)")
            let newX = CGFloat(thisCart.trackPos * 128 + 256)
            let newY = (thisCart.position.x / self.view!.frame.width * self.view!.frame.height)
            thisCart.position = CGPoint(x: newX, y: newY)
            
            self.addChild(thisCart)
        }
        
        for crystal in crystals {
            let thisCrystal = crystal as! Crystal
            //thisCrystal.size = thisCrystal.topDownSize
            //thisCrystal.texture = thisCrystal.topDownTexture
            println("trackPos : \(thisCrystal.trackPos)")
            let newX = CGFloat(thisCrystal.trackPos * 128 + 256)
            let newY = (thisCrystal.position.x / self.view!.frame.width * self.view!.frame.height)
            thisCrystal.position = CGPoint(x: newX, y: newY)
            
            self.addChild(thisCrystal)
        }
        
        backgroundColor = SKColor(red: 0.3, green: 0.738, blue: 0.2, alpha: 1.0)
        player.size = CGSize(width: 128.0, height: 96.0)
        player.position = CGPoint(x: CGFloat(player.pos * 128 + 256), y: 96.0)
        self.addChild(player)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        swipeLeft.direction = (UISwipeGestureRecognizerDirection.Left)
        self.view?.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        swipeRight.direction = (UISwipeGestureRecognizerDirection.Right)
        self.view?.addGestureRecognizer(swipeRight)
        
        
        // Not Used in this scene
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(swipeUp)
        // Not Used in this scene
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        self.view?.addGestureRecognizer(tapGesture)
        
        
//        tempSwitchButton = UIButton(frame: CGRect(x: 900, y: 50, width: 200, height: 100))
//        tempSwitchButton.setTitle("Switch!", forState: .Normal)
//        tempSwitchButton.layer.borderWidth = 3
//        tempSwitchButton.addTarget(self, action: "switchButtonTapped", forControlEvents: .TouchUpInside)
//        tempSwitchButton.layer.zPosition = 100
//        self.view?.addSubview(tempSwitchButton)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if !gameOver {
            updatePositions()
            //PDAlert: VIEW IS REMOVED
            if timeToNextCart == 0 { //Add Cart
                addCartVert()
                timeToNextCart = 60
            }
            
            if timeToNextViewCrystal == 0 { // add crystal
                addViewCrystal()
                timeToNextViewCrystal = 200
            }
            
            //PDAlert : May need better catch
            if invincibleFlag == true {
                invincibilityTime--
                if invincibilityTime == 0 {
                    invincibleFlag = false
                }
            }

            
            timeToNextCart--
            timeToNextViewCrystal--
        } else {
            //Game over!
            // Clean up and return to title Scene
        }
    }
    
    //Temp Function
    func switchButtonTapped() {
        println("switchTapped")
        let horScene = HorizontalScene(size: parentVC.view.bounds.size)
        horScene.player = self.player
        horScene.parentVC = parentVC
        horScene.timeToNextCart = timeToNextCart
        horScene.timeToNextViewCrystal = timeToNextViewCrystal
        horScene.scaleMode = .ResizeFill
        horScene.carts = self.carts
        horScene.crystals = self.crystals
        
        for cart in carts {
            cart.removeFromParent()
        }
        for crystal in crystals {
            crystal.removeFromParent()
        }
        self.player.removeFromParent()
        self.view?.presentScene(horScene)
    }
    
    func crystalHit(id: Int) {
        //STOP MOVING ACTIONS
        switch id {
        case 0...2: // Hor Crystal
            horCrystals++
            horCrystalLabel.text = "x \(horCrystals)"
        case 3...5: // TopDown Crystal
            topDownCrystals++
            topDownCrystalLabel.text = "x \(topDownCrystals)"
        case 6...8: // Front Crystal
            frontCrystals++
            frontCrystalLabel.text = "x \(frontCrystals)"
        case 9: // Invincibility Crystal
            invincibilityTime = 300
            invincibleFlag = true
        default: // Default (Hor)
            horCrystals++
        }
    }

    
    
    func swipeUp(gr: UISwipeGestureRecognizer) {
        println("Swipe Up")
    }
    func swipeDown(gr: UISwipeGestureRecognizer) {
        println("Swipe Down")
    }
    func swipeLeft(gr: UISwipeGestureRecognizer) {
        println("Swipe Left")
        if player.pos != 0 {
            moveLeft()
        }
    }
    func swipeRight(gr: UISwipeGestureRecognizer) {
        println("Swipe Right")
        if player.pos != 4 {
            moveRight()
        }
    }
    
    func tapped(gr: UITapGestureRecognizer) {
        println("Tapped")
    }
    
    func moveLeft() {
        // Move to Animation, change actual position after completion
        let actionMove = SKAction.moveTo(CGPoint(x: verticalPositions[player.pos - 1], y: player.position.y), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)

        self.player.pos = self.player.pos - 1 // Fix this
    }
    func moveRight() {
        // Move to Animation, change actual position after completion
        let actionMove = SKAction.moveTo(CGPoint(x: verticalPositions[player.pos + 1], y: player.position.y), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)
        player.pos = player.pos + 1 // Fix this
    }
    
    func horCrystalTapped() {
        //Just Display warning
        if !self.isKindOfClass(HorizontalScene) && horCrystals != 0 {
            player.removeAllActions()
            println("crystalHit")
            let horScene = HorizontalScene(size: parentVC.view.bounds.size)
            horScene.player = self.player
            horScene.parentVC = parentVC
            horScene.timeToNextCart = timeToNextCart
            horScene.timeToNextViewCrystal = timeToNextViewCrystal
            horScene.scaleMode = .ResizeFill
            horScene.carts = self.carts
            horScene.crystals = self.crystals
            
            for cart in carts {
                cart.removeFromParent()
            }
            for crystal in crystals {
                crystal.removeFromParent()
            }
            
            // Add top and Bottom Bar to TopDown then remove from Hor
            horScene.topBar = topBar
            horScene.menuButton = menuButton
            horScene.scoreLabel = scoreLabel
            horScene.score = score
            horScene.optionsButton = optionsButton
            horScene.horCrystals = horCrystals - 1
            horScene.topDownCrystals = topDownCrystals
            horScene.frontCrystals = frontCrystals
            
            horScene.bottomBar = bottomBar
            horScene.horCrystalImage = horCrystalImage
            horScene.horCrystalLabel = horCrystalLabel
            horScene.topDownCrystalImage = topDownCrystalImage
            horScene.topDownCrystalLabel = topDownCrystalLabel
            horScene.frontCrystalImage = frontCrystalImage
            horScene.frontCrystalLabel = frontCrystalLabel
            
            horScene.firstTimeFlag = firstTimeFlag
            
            topBar.removeFromSuperview()
            bottomBar.removeFromSuperview()
            
            self.player.removeFromParent()
            self.view?.presentScene(horScene)
        }  else { // else nothing, maybe display warning
            
        }
    }
    //In This View
    func topDownCrystalTapped() {
        //Just Display warning
        if !self.isKindOfClass(TopDownScene) && topDownCrystals != 0 {
            player.removeAllActions()
            println("switch tapped")
            let topDownScene = TopDownScene(size: parentVC.view.bounds.size)
            topDownScene.scaleMode = .ResizeFill
            topDownScene.timeToNextCart = timeToNextCart
            topDownScene.timeToNextViewCrystal = timeToNextViewCrystal
            topDownScene.player = self.player
            topDownScene.parentVC = parentVC
            topDownScene.carts = self.carts
            topDownScene.crystals = self.crystals
            for cart in carts {
                cart.removeFromParent()
            }
            for crystal in crystals {
                crystal.removeFromParent()
            }
            // Add top and Bottom Bar to TopDown then remove from Hor
            topDownScene.topBar = topBar
            topDownScene.menuButton = menuButton
            topDownScene.scoreLabel = scoreLabel
            topDownScene.score = score
            topDownScene.optionsButton = optionsButton
            topDownScene.horCrystals = horCrystals
            topDownScene.topDownCrystals = topDownCrystals - 1
            topDownScene.frontCrystals = frontCrystals
            
            topDownScene.bottomBar = bottomBar
            topDownScene.horCrystalImage = horCrystalImage
            topDownScene.horCrystalLabel = horCrystalLabel
            topDownScene.topDownCrystalImage = topDownCrystalImage
            topDownScene.topDownCrystalLabel = topDownCrystalLabel
            topDownScene.frontCrystalImage = frontCrystalImage
            topDownScene.frontCrystalLabel = frontCrystalLabel
            
            topDownScene.firstTimeFlag = firstTimeFlag
            
            topBar.removeFromSuperview()
            bottomBar.removeFromSuperview()
            
            self.player.removeFromParent()
            //self.view?.presentScene(topDownScene, transition: SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.5))
            self.view?.presentScene(topDownScene)
        } else { // else nothing, maybe display warning
            println("No Crystals or Same Class")
        }
    }
    
    func frontCrystalTapped() {
        
    }
    
    
    
    func addCartVert() {
        //Randomly Choose which Cart to add
        // Cart should have a vertical size, hor size, front size
        let randCart = Int(rand() % 3)
        let cartVelocity = CGFloat((rand() % 2) + 3)
        let cart = Cart(id: randCart, scene: 1)
        
        cart.size = cart.topDownSize
        let trackPos = Int(rand() % 5)
        cart.zPosition = CGFloat(trackPos)
        let actualX =  CGFloat((trackPos + 1) * 128 + 128)
        cart.trackPos = trackPos
        cart.position = CGPoint(x: actualX, y: self.frame.size.height + cart.size.height / 2)
        
        addChild(cart)
        carts.addObject(cart)
    }
    
    func addViewCrystal() {
        let crystalId = Int(rand() % 10)
        let crystalVelocity = CGFloat((rand() % 2) + 3)
        let crystal = Crystal(velocity: crystalVelocity, id: crystalId, scene: 1)
        crystal.size = crystal.topDownSize
        let trackPos = Int(rand() % 5)
        let actualX =  CGFloat((trackPos + 1) * 128 + 128)
        crystal.trackPos = trackPos
        crystal.position = CGPoint(x: actualX, y: self.frame.size.height + crystal.size.height / 2)
        addChild(crystal)
        crystals.addObject(crystal)
    }
    
    func updatePositions() {
        let playerTop = player.position.y + player.size.height / 2
        let playerBottom = player.position.y - player.size.height / 2
        for cart in carts {
            let thisCart = cart as! Cart
            thisCart.position.y -= thisCart.velocity
            if thisCart.position.y < -thisCart.size.height { // Probably can divide height by 2
                thisCart.removeFromParent()
                carts.removeObject(thisCart)
                score++
                scoreLabel.text = "Score: \(score)"
            }
            
            //Check Collisions
            // Flags will likely be here for item checks/invincibility
            if thisCart.trackPos == player.pos {
                if !invincibleFlag {
                    if ((playerTop > thisCart.position.y - thisCart.size.height / 2) && (playerTop  < thisCart.position.y + thisCart.size.height / 2)) || ((playerBottom > thisCart.position.y - thisCart.size.height / 2) && (playerBottom  < thisCart.position.y + thisCart.size.height / 2)){
                        //println("COLLISION!")
                        /////// GAME OVER ///////
                        gameOver = true
                        userInteractionEnabled = false
                        let titleScene = TitleScene(size: parentVC.view.bounds.size)
                        titleScene.parentVC = parentVC
                        for sub in view!.subviews {
                            sub.removeFromSuperview()
                        }
                        self.view?.presentScene(titleScene)
                        /////////////////////////
                    }
                }
            }
        }
        
        //PDAlert: Moving while hitting crystals wont be a problem if the move is handled properly
        for crystal in crystals {
            let thisCrystal = crystal as! Crystal
            thisCrystal.position.y -= thisCrystal.velocity
            if thisCrystal.position.y < -thisCrystal.size.height { // Probably can divide height by 2
                thisCrystal.removeFromParent()
                crystals.removeObject(thisCrystal)
            }
            
            //Check Collisions
            // Flags will likely be here for item checks/invincibility
            if thisCrystal.trackPos == player.pos {
                if ((playerTop > thisCrystal.position.y - thisCrystal.size.height / 2) && (playerTop  < thisCrystal.position.y + thisCrystal.size.height / 2)) || ((playerBottom > thisCrystal.position.y - thisCrystal.size.height / 2) && (playerBottom  < thisCrystal.position.y + thisCrystal.size.height / 2)){
                    //HIT CRYSTAL
                    crystalHit(thisCrystal.id)
                    crystals.removeObject(thisCrystal)
                    thisCrystal.removeFromParent()
                }
            }
        }
    }
    
    
    
}
