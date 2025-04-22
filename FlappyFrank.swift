//
//  FlappyFrank.swift
//  FlappyFrankGame
//
//  Created by Riddick R. Variano on 4/15/25.
//
import SwiftUI
import SpriteKit

class FlappyFrank: SKScene{
    let Frank = SKSpriteNode(texture: SKTexture(imageNamed: "Frank"))
    
    let Pipe = SKSpriteNode(imageNamed: "Pipe")
    
    
    override func sceneDidLoad() {
        //sky
        self.backgroundColor = .cyan
        
        //Frank
        self.addChild(Frank)
        Frank.position = CGPoint(x: 300 , y: 250)
        
        //Pipe
        self.addChild(Pipe)
        Pipe.position = CGPoint(x: 200, y: 200)
    }
}
