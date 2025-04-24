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
    
    let Start = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 100))
    
    var playing = false
    
    
    
    override func sceneDidLoad() {
        //sky
        self.backgroundColor = .cyan
        //Frank
        //        self.addChild(Frank)
        //        Frank.position = CGPoint(x: 500, y: 500)
        
        //Pipe
        self.addChild(Pipe)
        Pipe.position = CGPoint(x: 200, y: 200)
        let floor = SKSpriteNode(color: .green, size: CGSize(width: 1000, height: 40))
        
        floor.position = CGPoint(x: size.width / 2, y: 20)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        addChild(floor)
        let ceiling = SKSpriteNode(color: .black, size: CGSize(width: 1000, height: 40))
        ceiling.position = CGPoint(x: size.width / 2, y: 950)
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size)
        ceiling.physicsBody?.isDynamic = false
        addChild(ceiling)
        
        
        self.addChild(Start)

    }
        //Start Button
//        self.addChild(Start)
//        Start.position = CGPoint(x: size.width/2 , y: size.height / 4)
//        Start.name =
//    }
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .cyan
        Start.position = CGPoint(x: size.width/2, y: size.height / 4)
        Start.name = "start"
        
        
        
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        Frank.setScale(0.07)
        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        Frank.physicsBody?.affectedByGravity = true
        Frank.physicsBody?.allowsRotation = false
        addChild(Frank)
        physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        
        if(!playing){
            Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
            Frank.physicsBody?.affectedByGravity = false
            Frank.physicsBody?.allowsRotation = false
            physicsWorld.gravity = CGVector(dx: 0, dy: -25)
            Start.position = CGPoint(x: size.width/2, y: size.height / 4)
        }
    }
    func flap() {
        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
    }
    
    func start(){
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        playing = true
        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        Frank.physicsBody?.affectedByGravity = true
        Frank.physicsBody?.allowsRotation = false
        physicsWorld.gravity = CGVector(dx: 0, dy: -25)
        Start.position = CGPoint(x: 10000, y: 10000)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if touch == touches.first{
                enumerateChildNodes(withName: "//*", using: {(node, stop) in
                    if node.name == "start" {
                        if node.contains(touch.location(in: self)){
                            self.start()
                        }
                    }
                })
            }
        }
        
        if(playing){
            flap()
        }
        
        
        
    }
    
    
    
}

