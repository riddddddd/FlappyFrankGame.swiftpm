//
//  FlappyFrank.swift
//  FlappyFrankGame
//
//  Created by Riddick R. Variano on 4/15/25.
//
import SwiftUI
import SpriteKit

struct PhysicsCategory {
    static let frank: UInt32 = 0x1 << 0
    static let pipe: UInt32 = 0x1 << 1
    static let boundary: UInt32 = 0x1 << 2
}

class FlappyFrank: SKScene, SKPhysicsContactDelegate{
    
    let Frank = SKSpriteNode(imageNamed: "Frank")
    
    let Pipe = SKSpriteNode(imageNamed: "Pipe")
    
    let background = SKSpriteNode(imageNamed: "BackgroundImage")
    
    let Start = SKSpriteNode(imageNamed: "start")
    
    var playing = false
    
    
    
    override func sceneDidLoad() {
        //sky
        
        
        
        //Frank
        //        self.addChild(Frank)
        //        Frank.position = CGPoint(x: 500, y: 500)
        
        //Pipe
        self.addChild(Pipe)
        Pipe.position = CGPoint(x: 200, y: 200)
        Pipe.physicsBody = SKPhysicsBody(rectangleOf: Pipe.size)
        Pipe.physicsBody?.isDynamic = false
        Pipe.physicsBody?.categoryBitMask = PhysicsCategory.pipe
        Pipe.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        Pipe.physicsBody?.collisionBitMask = PhysicsCategory.frank
        
        //Floor
        let floor = SKSpriteNode(color: .systemGreen, size: CGSize(width: 1000, height: 40))
        
        floor.position = CGPoint(x: size.width / 2, y: 20)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        addChild(floor)
        floor.physicsBody?.categoryBitMask = PhysicsCategory.boundary
        floor.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        floor.physicsBody?.collisionBitMask = PhysicsCategory.frank
        
        
        //Ceiling
        
        let ceiling = SKSpriteNode(color: .clear, size: CGSize(width: 1000, height: 40))
        ceiling.position = CGPoint(x: size.width / 2, y: 950)
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size)
        ceiling.physicsBody?.isDynamic = false
        addChild(ceiling)
        ceiling.physicsBody?.categoryBitMask = PhysicsCategory.boundary
        ceiling.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        ceiling.physicsBody?.collisionBitMask = PhysicsCategory.frank
        
        
        
        self.addChild(Start)
        Start.name = "start"
        Start.setScale(0.1)
    }
    
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        background.size = self.size
        addChild(background)
        
        
        Start.position = CGPoint(x: size.width/2 - 25, y: size.height / 4)
        
        
        
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        Frank.setScale(0.07)
        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        Frank.physicsBody?.affectedByGravity = true
        Frank.physicsBody?.allowsRotation = false
        addChild(Frank)
        physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        Frank.physicsBody?.categoryBitMask = PhysicsCategory.frank
        Frank.physicsBody?.contactTestBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        Frank.physicsBody?.collisionBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        

        if !playing {
            Frank.physicsBody?.affectedByGravity = false
        }
    }
    func flap() {
        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
    }
    
    func start(){
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        playing = true
        print("playing = true")
        
        Frank.physicsBody?.affectedByGravity = true
        
        
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
    nonisolated func didBegin(_ contact: SKPhysicsContact) {
        let a = contact.bodyA.categoryBitMask
        let b = contact.bodyB.categoryBitMask
        
        if (a == PhysicsCategory.frank && b == PhysicsCategory.pipe) ||
            (a == PhysicsCategory.pipe && b == PhysicsCategory.frank) {
            print("Frank hit a pipe")
            
        }
        
        if (a == PhysicsCategory.frank && b == PhysicsCategory.boundary) ||
            (a == PhysicsCategory.boundary && b == PhysicsCategory.frank) {
            print("Frank hit the floor or ceiling")
            
        }
    }
    
    
}

