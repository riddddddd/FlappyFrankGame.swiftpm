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
    
    let Start = SKSpriteNode(imageNamed: "start")
    
    var playing = false
    var wasPlaying = true
    var score = 0
    
    var highscore = 0
    
    
    override func sceneDidLoad() {
        
        
        //        //Pipe
        //        self.addChild(Pipe)
        //        Pipe.position = CGPoint(x: 200, y: 200)
        //        Pipe.physicsBody = SKPhysicsBody(rectangleOf: Pipe.size)
        //        Pipe.physicsBody?.isDynamic = false
        //        Pipe.physicsBody?.categoryBitMask = PhysicsCategory.pipe
        //        Pipe.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        //        Pipe.physicsBody?.collisionBitMask = PhysicsCategory.frank
        
        let floor = SKSpriteNode(imageNamed: "grass")
        floor.setScale(0.5)
        floor.name = "floor"
        floor.position = CGPoint(x: size.width / 2, y: -10)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        addChild(floor)
        floor.physicsBody?.categoryBitMask = PhysicsCategory.boundary
        floor.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        floor.physicsBody?.collisionBitMask = PhysicsCategory.frank
        
        
        let moveFloor = SKAction.moveBy(x: -1479/2, y: 0, duration: 3.0)
        let resetFloor = SKAction.moveBy(x: 1479/2, y: 0, duration: 0.0)
        let moveFloorForever = SKAction.repeatForever(SKAction.sequence([moveFloor, resetFloor]))
        
        
        for i in 0..<3 {
            let floor = SKSpriteNode(imageNamed: "grass")
            floor.setScale(0.5)
            floor.position = CGPoint(x: CGFloat(i) * 1478/2, y: -10)
            floor.zPosition = 1
            
            floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
            floor.physicsBody?.isDynamic = false
            floor.physicsBody?.categoryBitMask = PhysicsCategory.boundary
            floor.physicsBody?.contactTestBitMask = PhysicsCategory.frank
            floor.physicsBody?.collisionBitMask = PhysicsCategory.frank
            
            
            floor.run(moveFloorForever)
            addChild(floor)
        }
        
        
        
        
        //Ceiling
        
//        let ceiling = SKSpriteNode(color: .black, size: CGSize(width: 1000, height: 40))
//        ceiling.position = CGPoint(x: size.width / 2, y: 950)
//        
//        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size)
//        ceiling.physicsBody?.isDynamic = false
//        addChild(ceiling)
//        ceiling.physicsBody?.categoryBitMask = PhysicsCategory.boundary
//        ceiling.physicsBody?.contactTestBitMask = PhysicsCategory.frank
//        ceiling.physicsBody?.collisionBitMask = PhysicsCategory.frank
//        ceiling.name = "ceiling"
        
        self.addChild(Start)
        Start.name = "start"
        Start.setScale(0.1)
        
    }
    
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        //ceiling
        let ceiling = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: 40))
        ceiling.position = CGPoint(x: size.width / 2, y: size.height - ceiling.size.height / 2 + 60)
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size)
        ceiling.physicsBody?.isDynamic = false
        ceiling.physicsBody?.categoryBitMask = PhysicsCategory.boundary
        ceiling.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        ceiling.physicsBody?.collisionBitMask = PhysicsCategory.frank
        ceiling.name = "ceiling"
        addChild(ceiling)
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        background.size = self.size
        addChild(background)
        
        
        Start.position = CGPoint(x: size.width / 2, y: size.height / 4)

        
        
        
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        Frank.setScale(0.07)
        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        Frank.physicsBody?.affectedByGravity = true
        Frank.physicsBody?.allowsRotation = true
        addChild(Frank)
        physicsWorld.gravity = CGVector(dx: 0, dy: -50)
        Frank.physicsBody?.categoryBitMask = PhysicsCategory.frank
        Frank.physicsBody?.contactTestBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        Frank.physicsBody?.collisionBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        
        
        if !playing {
            Frank.physicsBody?.affectedByGravity = false
            physicsWorld.gravity = CGVector(dx: 0, dy: -25)
            Start.position = CGPoint(x: size.width/2, y: size.height / 4)
        }
    }
    func flap() {
        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 130))
        Frank.physicsBody?.angularDamping = 20
        Frank.zRotation = 45


    }
    
    func start(){
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        playing = true
        print("playing = true")
        
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
            Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 1.8)
                Frank.physicsBody?.velocity = .zero
                Frank.physicsBody?.angularVelocity = 0
                Frank.zRotation = 0
            Start.position = CGPoint(x: size.width / 2, y: size.height / 4)

            }

        Frank.physicsBody?.angularVelocity += physicsWorld.gravity.dy/25

    }
    
}
