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

        override func didMove(to view: SKView) {
            backgroundColor = .cyan
                
            
          
            Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
            Frank.setScale(0.5)
            addChild(Frank)
            
            
            Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
            Frank.physicsBody? .affectedByGravity = true
            Frank.physicsBody? .allowsRotation = false
            
            
            
            physicsWorld.gravity = CGVector(dx: 0, dy: -5)
            
            
        }
    func flap() {
        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
    }
 
    
    
}
