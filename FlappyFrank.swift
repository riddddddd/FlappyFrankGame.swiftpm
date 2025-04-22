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
        self.addChild(Frank)
        Frank.position = CGPoint(x: 300 , y: 250)
        
        //Pipe
        self.addChild(Pipe)
        Pipe.position = CGPoint(x: 200, y: 200)
        
        //Start Button
        self.addChild(Start)
        Start.position = CGPoint(x: size.width/2 , y: size.height / 4)
        Start.name =
    }
    
    
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .cyan
        Start.position = CGPoint(x: size.width/2 - 25, y: size.height / 4)
        
        
        
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        Frank.setScale(0.5)
        
        if(playing){
            Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
            Frank.physicsBody?.affectedByGravity = true
            Frank.physicsBody?.allowsRotation = false
            physicsWorld.gravity = CGVector(dx: 0, dy: -20)
            Start.position = CGPoint(x: 10000, y: 10000)
        }
    }
    func flap() {
        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 130))
    }
    
    func start(){
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        playing = true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        flap()
    }
    
    func button() {
        
    }
    
    
    
}

