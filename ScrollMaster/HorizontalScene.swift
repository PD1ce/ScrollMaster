//
//  HorizontalScene.swift
//  ScrollMaster
//
//  Created by Philip Deisinger on 3/9/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import SpriteKit

class HorizontalScene: SKScene {
    
    var parentVC: UIViewController!
    var player: Player!
    var tracks: NSMutableArray!
    var gameOver: Bool = false
    var score = Int()
    //PDAlert, should have blank spaces in array open for bonus tracks? Check swipe if bonus is open then move to new index
    let horizontalPositions = [CGFloat(640.0), CGFloat(512.0), CGFloat(384.0), CGFloat(256.0), CGFloat(128.0)] //Track 0, 1, 2, 3, 4
    var tempSwitchButton: UIButton!
    var timeToNextCart = Int()
    var timeToNextViewCrystal = Int()
    var carts = NSMutableArray()
    var crystals = NSMutableArray()
    
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
        
        // Add Gesture Recognizers to Crystals, or just make them buttons...
        let horCrystalGR = UITapGestureRecognizer(target: self, action: "horCrystalTapped")
        horCrystalImage.addGestureRecognizer(horCrystalGR)
        bottomBar.addSubview(horCrystalImage)
        horCrystalLabel.text = "x \(horCrystals)"
        bottomBar.addSubview(horCrystalLabel)
        bottomBar.addSubview(topDownCrystalImage)
        let topDownCrystalGR = UITapGestureRecognizer(target: self, action: "topDownCrystalTapped")
        topDownCrystalImage.addGestureRecognizer(topDownCrystalGR)
        topDownCrystalLabel.text = "x \(topDownCrystals)"
        bottomBar.addSubview(topDownCrystalLabel)
        bottomBar.addSubview(frontCrystalImage)
        let frontCrystalGR = UITapGestureRecognizer(target: self, action: "frontCrystalTapped")
        frontCrystalImage.addGestureRecognizer(frontCrystalGR)
        frontCrystalLabel.text = "x \(frontCrystals)"
        bottomBar.addSubview(frontCrystalLabel)
        view.addSubview(bottomBar)
        
        if firstTimeFlag {
            topBar.frame.origin = CGPoint(x: 0, y: -topBar.frame.height)
            bottomBar.frame.origin = CGPoint(x: 0, y: view.frame.height)
            
            UIView.animateWithDuration(0.5, delay: 0.2, options: .CurveEaseOut, animations: {
                self.topBar.frame.origin = CGPoint(x: 0, y: 0)
                self.bottomBar.frame.origin = CGPoint(x: 0, y: view.frame.height - self.bottomBar.frame.height)
                }, completion: {
                    (value: Bool) in
                    self.firstTimeFlag = false
            })
        }
        
        /////////////////////////////////////////
        
        userInteractionEnabled = true
        tracks = NSMutableArray()
        for var i = 0; i < 5; i++ {
            let track = SKSpriteNode(color: UIColor(red: 0.644, green: 0.164, blue: 0.164, alpha: 1.0), size: CGSize(width: self.frame.width, height: 32.0))
            let realY = CGFloat((i + 1) * 128 - 32)
            track.position = CGPoint(x: CGRectGetMidX(self.frame), y: realY)
            println("Track \(i) X: \(track.position.x), Track \(i) Y: \(track.position.y)")
            track.zPosition = -2
            self.addChild(track)
            tracks.addObject(track)
        }
        
        // New carts should likely be created and replace those in carts because the sprite will change
        // Or just change texture/size?
        for cart in carts {
            let thisCart = cart as! Cart
            thisCart.size = thisCart.horSize
            thisCart.texture = thisCart.horTexture
            println("trackPos : \(thisCart.trackPos)")
            let newY = CGFloat(self.view!.frame.height - CGFloat(thisCart.trackPos * 128 + 128)) + thisCart.size.height / 4
            let newX = (thisCart.position.y / self.view!.frame.height * self.view!.frame.width)
            thisCart.position = CGPoint(x: newX, y: newY)
            
            self.addChild(thisCart)
        }
        
        for crystal in crystals {
            let thisCrystal = crystal as! Crystal
            //thisCrystal.size = thisCrystal.horSize
            //thisCrystal.texture = thisCrystal.horTexture
            let newY = CGFloat(self.view!.frame.height - CGFloat(thisCrystal.trackPos * 128 + 128)) + thisCrystal.size.height / 4
            let newX = (thisCrystal.position.y / self.view!.frame.height * self.view!.frame.width)
            thisCrystal.position = CGPoint(x: newX, y: newY)
            
            self.addChild(thisCrystal)

        }
        
        backgroundColor = SKColor(red: 0.3, green: 0.738, blue: 0.2, alpha: 1.0)
        player.size = CGSize(width: 128.0, height: 96.0)
        player.position = CGPoint(x: CGFloat(128.0), y: self.view!.frame.height - CGFloat(player.pos * 128 + 128))
        self.addChild(player)
        
        // Not Used in this scene
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        swipeLeft.direction = (UISwipeGestureRecognizerDirection.Left)
        self.view?.addGestureRecognizer(swipeLeft)
        // Not Used in this scene
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        swipeRight.direction = (UISwipeGestureRecognizerDirection.Right)
        self.view?.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        self.view?.addGestureRecognizer(tapGesture)
        
//        tempSwitchButton = UIButton(frame: CGRect(x: 900, y: 50, width: 200, height: 100))
//        tempSwitchButton.setTitle("Switch!", forState: .Normal)
//        tempSwitchButton.layer.borderWidth = 3
//        //tempSwitchButton.titleLabel?.text = "Switch!"
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
                addCartHor()
                timeToNextCart = 60
            }
            
            if timeToNextViewCrystal == 0 { // add crystal
                addViewCrystal()
                timeToNextViewCrystal = 200
            }
            
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
    
    //Temp
    func switchButtonTapped() {
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
        self.player.removeFromParent()
        //self.view?.presentScene(topDownScene, transition: SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.5))
        self.view?.presentScene(topDownScene)
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
        if player.pos != 0 {
            moveUp()
        }
    }
    func swipeDown(gr: UISwipeGestureRecognizer) {
        println("Swipe Down")
        if player.pos != 4 {
            moveDown()
        }
    }
    func swipeLeft(gr: UISwipeGestureRecognizer) {
        println("Swipe Left")
    }
    func swipeRight(gr: UISwipeGestureRecognizer) {
        println("Swipe Right")
    }
    
    func tapped(gr: UITapGestureRecognizer) {
        println("Tapped")
    }
    
    func moveUp() {
        // Move to Animation, change actual position after completion
        
        let actionMove = SKAction.moveTo(CGPoint(x: player.position.x, y: horizontalPositions[player.pos - 1]), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)
        player.pos = player.pos - 1
        
    }
    func moveDown() {
        // Move to Animation, change actual position after completion
        let actionMove = SKAction.moveTo(CGPoint(x: player.position.x, y: horizontalPositions[player.pos + 1]), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)
        player.pos = player.pos + 1 // Fix this
    }
    
    //Already in this view!
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
            
        }
    }
    
    func frontCrystalTapped() {
        
    }

    
    func addCartHor() {
        //PDAlert: Cart z's based on track pos
        //Randomly generate cart ID
        let randCart = Int(rand() % 3)
        let cart = Cart(id: randCart, scene: 0)

        cart.size = cart.horSize
        let trackPos = Int(rand() % 5)
        cart.zPosition = CGFloat(trackPos)
        //PDAlert: Has thrown an error if switching via button
        let actualY = self.view!.frame.height - CGFloat((trackPos + 1) * 128) + cart.size.height / 4
        cart.trackPos = trackPos
        cart.position = CGPoint(x: self.frame.size.width + cart.size.width/2, y: actualY)
        
        addChild(cart)
        carts.addObject(cart)
    }
    
    func addViewCrystal() {
        //let crystalId = 9
        let crystalId = Int(rand() % 10)
        let crystalVelocity = CGFloat((rand() % 2) + 3)
        let crystal = Crystal(velocity: crystalVelocity, id: crystalId, scene: 0)
        crystal.size = crystal.horSize
        let trackPos = Int(rand() % 5)
        let actualY = self.view!.frame.height - CGFloat((trackPos + 1) * 128) + crystal.size.height / 4
        crystal.trackPos = trackPos
        crystal.position = CGPoint(x: self.frame.size.width + crystal.size.width/2, y: actualY)
        addChild(crystal)
        crystals.addObject(crystal)
    }
    
    func updatePositions() {
        //Probably should just do objects in objects
        let playerFront = player.position.x + player.size.width / 2
        let playerBack = player.position.x - player.size.width / 2
        for cart in carts {
            let thisCart = cart as! Cart
            //PDAlert
            thisCart.position.x -= thisCart.velocity
            if thisCart.position.x < -thisCart.size.width {
                thisCart.removeFromParent()
                carts.removeObject(thisCart)
                score++
                scoreLabel.text = "Score: \(score)"
            }
            if thisCart.trackPos == player.pos {
                if ((playerFront > thisCart.position.x - thisCart.size.width / 2) && (playerFront < thisCart.position.x + thisCart.size.width / 2)) || ((playerBack > thisCart.position.x - thisCart.size.width / 2) && (playerBack < thisCart.position.x + thisCart.size.width / 2)) {
                    
                    if !invincibleFlag {
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
                    } else {
                        thisCart.removeFromParent()
                        carts.removeObject(thisCart)
                        score++
                        scoreLabel.text = "Score: \(score)"
                    }
                    
                }
            } else {
            
            }
        }
        //PDAlert: Sometimes a crystal that is hit in the bottom lane makes everything dissappear
        var crystalWasHit = false
        for crystal in crystals {
            let thisCrystal = crystal as! Crystal
            thisCrystal.position.x -= thisCrystal.velocity
            if thisCrystal.position.x < -thisCrystal.size.width {
                thisCrystal.removeFromParent()
                crystals.removeObject(thisCrystal)
            }
            if thisCrystal.trackPos == player.pos {
                if ((playerFront > thisCrystal.position.x - thisCrystal.size.width / 2) && (playerFront < thisCrystal.position.x + thisCrystal.size.width / 2)) || ((playerBack > thisCrystal.position.x - thisCrystal.size.width / 2) && (playerBack < thisCrystal.position.x + thisCrystal.size.width / 2)) {
                    //Hit
                    crystalHit(thisCrystal.id)
                    crystals.removeObject(crystal)
                    thisCrystal.removeFromParent()
                    
                }
            }
        }
    }
}
