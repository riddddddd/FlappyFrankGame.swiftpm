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
                
            
          
            Frank.position = CGPoint(x: size.width / 2, y: size.height / 2)
            Frank.setScale(0.5)
            addChild(Frank)
        }
}
