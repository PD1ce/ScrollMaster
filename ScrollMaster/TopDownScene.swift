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
    
    let player = SKSpriteNode(imageNamed: "MinecartTemp")
    var tracks: NSMutableArray!
    let horizontalPositions = [CGFloat(128.0), CGFloat(256.0), CGFloat(384.0), CGFloat(512.0), CGFloat(640.0)] //Track 0, 1, 2, 3, 4
    var playerPosition: Int! // Subclass player and make this a property
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        tracks = NSMutableArray()
        for var i = 0; i < 5; i++ {
            let track = SKSpriteNode(color: UIColor(red: 0.644, green: 0.164, blue: 0.164, alpha: 1.0), size: CGSize(width: self.frame.width, height: 32.0))
            let realY = CGFloat((i + 1) * 128 - 32)
            track.position = CGPoint(x: CGRectGetMidX(self.frame), y: realY)
            println("Track \(i) X: \(track.position.x), Track \(i) Y: \(track.position.y)")
            self.addChild(track)
            tracks.addObject(track)
        }
        
        playerPosition = 2
        
        backgroundColor = SKColor(red: 0.3, green: 0.738, blue: 0.2, alpha: 1.0)
        player.size = CGSize(width: 128.0, height: 96.0)
        player.position = CGPoint(x: CGFloat(128.0), y: CGRectGetMidY(self.frame))
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
                SKAction.runBlock(addCart),
                SKAction.waitForDuration(1.0)
                ])
            ))
        
        // Not Used in this scene
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        swipeLeft.direction = (UISwipeGestureRecognizerDirection.Left)
        //self.view?.addGestureRecognizer(swipeLeft)
        // Not Used in this scene
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        swipeRight.direction = (UISwipeGestureRecognizerDirection.Right)
        //self.view?.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
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
        if playerPosition != 4 {
            moveUp()
        }
    }
    func swipeDown(gr: UISwipeGestureRecognizer) {
        println("Swipe Down")
        if playerPosition != 0 {
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
        let actionMove = SKAction.moveTo(CGPoint(x: player.position.x, y: horizontalPositions[playerPosition + 1]), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)
        playerPosition! += 1 // Fix this
    }
    func moveDown() {
        let actionMove = SKAction.moveTo(CGPoint(x: player.position.x, y: horizontalPositions[playerPosition - 1]), duration: NSTimeInterval(0.5))
        player.runAction(actionMove)
        playerPosition! -= 1 // Fix this
    }
    
    func addCart() {
        let cart = SKSpriteNode(imageNamed: "MinecartTemp")
        cart.size = CGSize(width: 128.0, height: 96.0)
        
        let actualY = CGFloat(((rand() % 5) + 1) * 128)
        //let actualY = CGFloat(96.0) //Will be random
        cart.position = CGPoint(x: self.frame.size.width + cart.size.width/2, y: actualY)
        addChild(cart)
        println("Cart Y: \(cart.position.y)")
        let cartDuration = CGFloat((rand() % 2) + 3) // Will be random
        
        let actionMove = SKAction.moveTo(CGPoint(x: -cart.size.width/2, y: actualY), duration: NSTimeInterval(cartDuration))
        let actionMoveDone = SKAction.removeFromParent()
        cart.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
    }

}
