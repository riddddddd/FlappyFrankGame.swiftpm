//
//  FlappyFrank.swift
//  FlappyFrankGame
//
//  Created by Riddick R. Variano on 4/15/25.
//
import SwiftUI
import SpriteKit

class FlappyFrank: SKScene{
    let Frank = SKSpriteNode(imageNamed: "Frank")
    
    let Pipe = SKSpriteNode(imageNamed: "Pipe")
    
    
    override func sceneDidLoad() {
        //sky
        self.backgroundColor = .cyan
        
        //Frank
        self.addChild(Frank)
        Frank.position = CGPoint(x: 500, y: 500)
        
        //Pipe (work in progress)
        self.addChild(Pipe)
        Pipe.position = CGPoint(x: 200, y: 200)
        
        
        
    }
    

    
    
    
    
    /*This keeps crashing it*/
    //        override func didMove(to view: SKView) {
    //            backgroundColor = .cyan
    //
    //
    //
    //            Frank.position = CGPoint(x: size.width / 2, y: size.height / 2)
    //            Frank.setScale(0.5)
    //            addChild(Frank)
    //        }
    
    
    
    
//    override func didMove(to view: SKView) {
//        Frank.position = CGPoint(x: size.width / 2, y: size.height / 2)
//        Frank.setScale(0.5)
//        addChild(Frank)
//        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
//        Frank.physicsBody? .affectedByGravity = true
//        Frank.physicsBody? .allowsRotation = false
//        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
//    }
//    func flap() {
//        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
//    }
//    
    
    
}
