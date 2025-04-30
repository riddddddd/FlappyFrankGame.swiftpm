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
@MainActor
class FlappyFrank: SKScene, SKPhysicsContactDelegate{
    
    let Frank = SKSpriteNode(imageNamed: "Frank")
    
    let Pipe = SKSpriteNode(imageNamed: "Pipe")
    
    let background = SKSpriteNode(imageNamed: "BackgroundImage")
    
    let Start = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 100))
    
    var playing = true
    var wasPlaying = true
    
    
    
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
        floor.name = "floor"
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
        ceiling.name = "ceiling"
        
        
        self.addChild(Start)
        
    }
    //Start Button
    //        self.addChild(Start)
    //        Start.position = CGPoint(x: size.width/2 , y: size.height / 4)
    //        Start.name =
    //    }
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
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
        
        
        //        if(!playing){
        //            Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        //            Frank.physicsBody?.affectedByGravity = false
        //            Frank.physicsBody?.allowsRotation = false
        //            physicsWorld.gravity = CGVector(dx: 0, dy: -25)
        //            Start.position = CGPoint(x: size.width/2, y: size.height / 4)
        //        }
        // this version works better
        if !playing {
            Frank.physicsBody?.affectedByGravity = false
            physicsWorld.gravity = CGVector(dx: 0, dy: -25)
            Start.position = CGPoint(x: size.width/2, y: size.height / 4)
        }
    }
    func flap() {
        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
    }
    
    func start(){
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        playing = true
        
        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        Frank.physicsBody?.affectedByGravity = true
        Frank.physicsBody?.allowsRotation = false
        Frank.physicsBody?.categoryBitMask = PhysicsCategory.frank
        Frank.physicsBody?.contactTestBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        Frank.physicsBody?.collisionBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        
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
    
    
    override func update(_ currentTime: TimeInterval) {
        if Frank.frame.intersects(Pipe.frame) {
            print("Frank collided with a pipe")
            playing = false
        }
        
        for node in self.children {
            if node.name == "floor" || node.name == "ceiling" {
                if Frank.frame.intersects(node.frame) {
                    print("Frank hit the floor or ceiling")
                    playing = false
                }
            }
        }
        if wasPlaying && !playing {
                Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
                Frank.physicsBody?.velocity = .zero
                Frank.physicsBody?.angularVelocity = 0
                Frank.zRotation = 0
            }

    }
    
}
