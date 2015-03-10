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

class TopDownScene: SKScene {
    
    var parentVC: UIViewController!
    var player: SKSpriteNode!
    var tracks: NSMutableArray!
    let verticalPositions = [CGFloat(256.0), CGFloat(384.0), CGFloat(512.0), CGFloat(640.0), CGFloat(768.0)] //Track 0, 1, 2, 3, 4
    var playerPosition: Int! // Subclass player and make this a property
    var tempSwitchButton: UIButton!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        player = SKSpriteNode(imageNamed: "MinecartTemp")
        tracks = NSMutableArray()
        for var i = 0; i < 5; i++ {
            let track = SKSpriteNode(color: UIColor(red: 0.644, green: 0.164, blue: 0.164, alpha: 1.0), size: CGSize(width: 32.0, height: self.frame.width))
            let realX = CGFloat((i + 1) * 128 + 128)
            track.position = CGPoint(x: realX, y: CGRectGetMidY(self.frame))
            println("Track \(i) X: \(track.position.x), Track \(i) Y: \(track.position.y)")
            self.addChild(track)
            tracks.addObject(track)
        }
        
        playerPosition = 2
        
        backgroundColor = SKColor(red: 0.3, green: 0.738, blue: 0.2, alpha: 1.0)
        player.size = CGSize(width: 128.0, height: 96.0)
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: 96.0)
        self.addChild(player)
        /*
        runAction(SKAction.repeatActionForever(
        SKAction.sequence([
        SKAction.runBlock(addCart()),
        SKAction.waitForDuration(2.0)
        ])
        */
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addCartVert),
                SKAction.waitForDuration(1.0)
                ])
            ))
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        swipeLeft.direction = (UISwipeGestureRecognizerDirection.Left)
        self.view?.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        swipeRight.direction = (UISwipeGestureRecognizerDirection.Right)
        self.view?.addGestureRecognizer(swipeRight)
        
        // Not Used in this scene
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        //self.view?.addGestureRecognizer(swipeUp)
        // Not Used in this scene
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        //self.view?.addGestureRecognizer(swipeDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        self.view?.addGestureRecognizer(tapGesture)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    func swipeUp(gr: UISwipeGestureRecognizer) {
        println("Swipe Up")
    }
    func swipeDown(gr: UISwipeGestureRecognizer) {
        println("Swipe Down")
    }
    func swipeLeft(gr: UISwipeGestureRecognizer) {
        println("Swipe Left")
        if playerPosition != 0 {
            moveLeft()
        }
    }
    func swipeRight(gr: UISwipeGestureRecognizer) {
        println("Swipe Right")
        if playerPosition != 4 {
            moveRight()
        }
    }
    
    func tapped(gr: UITapGestureRecognizer) {
        println("Tapped")
    }
    
    func moveLeft() {
        let actionMove = SKAction.moveTo(CGPoint(x: verticalPositions[playerPosition - 1], y: player.position.y), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)
        playerPosition! -= 1 // Fix this
    }
    func moveRight() {
        let actionMove = SKAction.moveTo(CGPoint(x: verticalPositions[playerPosition + 1], y: player.position.y), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)
        playerPosition! += 1 // Fix this
    }
    
    func addCartVert() {
        let cart = SKSpriteNode(imageNamed: "MinecartTemp")
        cart.size = CGSize(width: 128.0, height: 96.0)
        
        let actualX = CGFloat(((rand() % 5) + 1) * 128 + 128)
        //let actualY = CGFloat(96.0) //Will be random
        cart.position = CGPoint(x: actualX, y: self.frame.size.height + cart.size.height/2)
        addChild(cart)
        println("Cart X: \(cart.position.x)")
        let cartDuration = CGFloat((rand() % 2) + 3) // Will be random
        
        let actionMove = SKAction.moveTo(CGPoint(x: actualX, y: -cart.size.width/2), duration: NSTimeInterval(cartDuration))
        let actionMoveDone = SKAction.removeFromParent()
        cart.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
    }

}
