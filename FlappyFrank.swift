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
    let scoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let highscoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let OtherscoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let gameOverLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let easterEggLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let easterEggLabel2 = SKLabelNode(fontNamed: "Courier-Bold")
    var playing = false
    var wasPlaying = true
    var score = 0
    var passedPipes: [SKNode] = []
    var highscore = 0
    var settingsButton: SKSpriteNode?
    var darkModeButton: SKSpriteNode!
    var isDarkMode = false

    
    
    
    @AppStorage("HighScore") var HighScore = 0
    @AppStorage("selectedFrank") var selectedFrank: String = "Frank"

    
    
    
   
    

    
    
    override func sceneDidLoad() {
        let floor = SKSpriteNode(imageNamed: "grass")
        floor.setScale(1)
        floor.name = "floor"
        floor.position = CGPoint(x: size.width / 2, y: -130)
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
            floor.zPosition = 5
            floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
            floor.physicsBody?.isDynamic = false
            floor.physicsBody?.categoryBitMask = PhysicsCategory.boundary
            floor.physicsBody?.contactTestBitMask = PhysicsCategory.frank
            floor.physicsBody?.collisionBitMask = PhysicsCategory.frank
            floor.run(moveFloorForever)
            addChild(floor)
        }
        
        self.addChild(Start)
        Start.name = "start"
        Start.setScale(0.1)
        
        
        
        
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        settingsButton = SKSpriteNode(imageNamed: "settingsIcon")
        if let settingsButton = settingsButton {
            settingsButton.name = "settings"
            settingsButton.setScale(0.5)
            settingsButton.position = CGPoint(x: size.width - 75, y: size.height - 75)
            settingsButton.zPosition = 100
            addChild(settingsButton)
        }

        
        darkModeButton = SKSpriteNode(imageNamed: "MoonImage")
        darkModeButton.name = "darkModeButton"
        darkModeButton.setScale(0.38)
        darkModeButton.position = CGPoint(x: 75, y: size.height - 70)
        darkModeButton.zPosition = 100
        addChild(darkModeButton)
        
        
        
       
        
        let cameraNode = SKCameraNode()
        self.camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cameraNode)

        
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
     
        Frank.texture = SKTexture(imageNamed: selectedFrank)

        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        Frank.setScale(0.07)
        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        Frank.physicsBody?.affectedByGravity = true
        Frank.physicsBody?.allowsRotation = true
        addChild(Frank)
        physicsWorld.gravity = CGVector(dx: 0, dy: -50)
        Frank.physicsBody?.categoryBitMask = PhysicsCategory.frank
        Frank.physicsBody?.contactTestBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        Frank.physicsBody?.collisionBitMask = PhysicsCategory.boundary
        
        if !playing {
            Frank.physicsBody?.affectedByGravity = false
            physicsWorld.gravity = CGVector(dx: 0, dy: -25)
            Start.position = CGPoint(x: size.width / 2, y: size.height / 4)
        }
        
        let spawn = SKAction.run { [weak self] in
            if self?.playing == true {
                self?.spawnPipes()
            }
        }
        let delay = SKAction.wait(forDuration: 2.5)
        let spawnForever = SKAction.repeatForever(SKAction.sequence([spawn, delay]))
        self.run(spawnForever)
        
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 170)
        scoreLabel.zPosition = 10
        
        addChild(scoreLabel)
        
        highscoreLabel.fontSize = 35
        highscoreLabel.fontColor = .black
        highscoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 550)
        highscoreLabel.zPosition = 10
        highscoreLabel.text = "Highscore: \(highscore)"
        addChild(highscoreLabel)
        
        scoreLabel.isHidden = true
        highscoreLabel.isHidden = true
        
        
        gameOverLabel.fontSize = 65
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        gameOverLabel.zPosition = 30
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.isHidden = true
        addChild(gameOverLabel)
        
        easterEggLabel.fontSize = 50
        easterEggLabel.fontColor = .green
        easterEggLabel.position = CGPoint(x: size.width / 2, y: size.height - 250)
        easterEggLabel.zPosition = 15
        easterEggLabel.text = "Good Job!"
        easterEggLabel.isHidden = true
        addChild(easterEggLabel)

       
        
        easterEggLabel2.fontSize = 15
        easterEggLabel2.fontColor = .red
        easterEggLabel2.position = CGPoint(x: size.width / 2, y: size.height - 250)
        easterEggLabel2.zPosition = 15
        easterEggLabel2.text = "You Reached Will's High Score"
        easterEggLabel2.isHidden = true
        addChild(easterEggLabel2)
        
        
        
        
    }
    
    func flap() {
        Frank.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        Frank.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 125))
        Frank.physicsBody?.angularDamping = 20
        Frank.zRotation = 45
    }
    
    func start(){
        Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2)
        playing = true
        print("playing = true")
        
        updateFrankTexture()
        settingsButton?.isHidden = true
        darkModeButton?.isHidden = true
        
        Frank.physicsBody = SKPhysicsBody(rectangleOf: Frank.size)
        Frank.physicsBody?.affectedByGravity = true
        Frank.physicsBody?.allowsRotation = false
        Frank.physicsBody?.categoryBitMask = PhysicsCategory.frank
        Frank.physicsBody?.contactTestBitMask = PhysicsCategory.pipe | PhysicsCategory.boundary
        Frank.physicsBody?.collisionBitMask = PhysicsCategory.boundary
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -25)
        Start.position = CGPoint(x: 10000, y: 10000)
        
        score = 0
        
        passedPipes.removeAll()
        scoreLabel.isHidden = false
        highscoreLabel.isHidden = true
        score = 0
        scoreLabel.text = "0"
        scoreLabel.isHidden = false
        highscoreLabel.isHidden = true
        passedPipes.removeAll()
        
        gameOverLabel.isHidden = true
        
        
      
      
        
        
    }
    func toggleDarkMode() {
        isDarkMode.toggle()
        
        if isDarkMode {
            background.texture = SKTexture(imageNamed: "BackgroundImageDark")
            darkModeButton.texture = SKTexture(imageNamed: "SunImage")
            
        } else {
            background.texture = SKTexture(imageNamed: "BackgroundImage")
            darkModeButton.texture = SKTexture(imageNamed: "MoonImage")
        }
        
    }
    
    
    
    
    
    
    
    func updateFrankTexture() {
        Frank.texture = SKTexture(imageNamed: selectedFrank)
    }
//   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNode = atPoint(location)
        
        if tappedNode.name == "darkModeButton" {
            toggleDarkMode()
            return
        }
        
        
        
        
        for touch in touches {
            let location = touch.location(in: self)

            // Check if the settings button was tapped
            let tappedNode = atPoint(location)
            if tappedNode.name == "settings" {
                if let view = self.view {
                    let vc = UIHostingController(rootView: FrankSettingsView())
                    view.window?.rootViewController?.present(vc, animated: true)
                }
            }
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

    
    func spawnPipes() {
        let pipeGap: CGFloat = CGFloat.random(in: 240...290)
        let pipeWidth: CGFloat = 75
        
        let bottomTexture = SKTexture(imageNamed: "bottomPipe")
        let topTexture = SKTexture(imageNamed: "topPipe")
        
        let maxY = size.height - pipeGap / 2 - 100
        let minY = pipeGap / 2 + 100
        let gapCenterY = CGFloat.random(in: minY...maxY)
        
        // Bottom pipe
        let bottomHeight = gapCenterY - pipeGap / 2
        let bottomPipe = SKSpriteNode(texture: bottomTexture)
        bottomPipe.size = CGSize(width: pipeWidth, height: bottomHeight)
        bottomPipe.anchorPoint = CGPoint(x: 0.5, y: 0)
        bottomPipe.position = CGPoint(x: size.width + pipeWidth, y: 0)
        bottomPipe.zPosition = 1
        bottomPipe.name = "pipe"
        bottomPipe.physicsBody = SKPhysicsBody(rectangleOf: bottomPipe.size)
        bottomPipe.physicsBody?.isDynamic = false
        bottomPipe.physicsBody?.categoryBitMask = PhysicsCategory.pipe
        bottomPipe.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        bottomPipe.physicsBody?.collisionBitMask = PhysicsCategory.frank | PhysicsCategory.boundary
        
        // Top pipe
        let topHeight = size.height - gapCenterY - pipeGap / 2
        let topPipe = SKSpriteNode(texture: topTexture)
        topPipe.size = CGSize(width: pipeWidth, height: topHeight)
        topPipe.anchorPoint = CGPoint(x: 0.5, y: 0)
        topPipe.position = CGPoint(x: size.width + pipeWidth, y: gapCenterY + pipeGap / 2)
        topPipe.zPosition = 1
        topPipe.name = "pipe"
        topPipe.physicsBody = SKPhysicsBody(rectangleOf: topPipe.size)
        topPipe.physicsBody?.isDynamic = false
        topPipe.physicsBody?.categoryBitMask = PhysicsCategory.pipe
        topPipe.physicsBody?.contactTestBitMask = PhysicsCategory.frank
        topPipe.physicsBody?.collisionBitMask = PhysicsCategory.frank | PhysicsCategory.boundary
        
        // Move pipes
        let movePipes = SKAction.moveBy(x: -size.width - 500, y: 0, duration: 4.0)
        let removePipes = SKAction.removeFromParent()
        let pipeSequence = SKAction.sequence([movePipes, removePipes])
        
        bottomPipe.run(pipeSequence)
        topPipe.run(pipeSequence)
        
        addChild(bottomPipe)
        addChild(topPipe)
        
        bottomPipe.userData = ["scored": false]
        passedPipes.append(bottomPipe)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !playing { return }
        
        for node in self.children {
            if node.name == "floor" || node.name == "ceiling" || node.name == "pipe" {
                if Frank.frame.intersects(node.frame) {
                    print("Frank touched something")
                    playing = false
                    if(HighScore < score){
                        HighScore = score
                    }
                    settingsButton?.isHidden = false
                    darkModeButton?.isHidden = false
                    shakeScreen()
                    break
                }
                
            }
        }
        
        if score == 10 {
            easterEggLabel.isHidden = false
       
            let fadeOut = SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.fadeOut(withDuration: 1.0),
                SKAction.run { self.easterEggLabel.isHidden = true; self.easterEggLabel.alpha = 1.0 }
            ])
            easterEggLabel.run(fadeOut)
        }
        
        
        if score == 36 {
            easterEggLabel2.isHidden = false
            
            let fadeOut = SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.fadeOut(withDuration: 1.0),
                SKAction.run { self.easterEggLabel2.isHidden = true; self.easterEggLabel2.alpha = 1.0 }
                ])
            easterEggLabel2.run(fadeOut)
            
                                            }
    

        
        func shakeScreen() {
            if let camera = self.camera {
                let moveRight = SKAction.moveBy(x: 10, y: 0, duration: 0.03)
                let moveLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.03)
                let shake = SKAction.sequence([moveRight, moveLeft, moveLeft, moveRight])
                camera.run(shake)
            }
        }


        
        if wasPlaying && !playing {
            Frank.position = CGPoint(x: size.width / 2 - 100, y: size.height / 1.8)
            Frank.physicsBody?.affectedByGravity = false
            Frank.physicsBody?.velocity = .zero
            Frank.physicsBody?.angularVelocity = 0
            Frank.zRotation = 0
            
            
            self.children.filter { $0.name == "pipe" }.forEach { $0.removeFromParent() }
            
            Start.position = CGPoint(x: size.width / 2, y: size.height / 4)
            
            scoreLabel.isHidden = false
            highscoreLabel.isHidden = false
            highscoreLabel.text = "Highscore: \(HighScore)"
            
            gameOverLabel.isHidden = false
        }
        
        wasPlaying = playing
        
        Frank.physicsBody?.angularVelocity += physicsWorld.gravity.dy / 25
        
        for pipe in passedPipes {
            if let scored = pipe.userData?["scored"] as? Bool, !scored {
                if pipe.position.x + pipe.frame.width / 2 < Frank.position.x {
                    score += 1
                    scoreLabel.text = "\(score)"
                    pipe.userData?["scored"] = true
                }
                if highscore < score{
                    highscore = score
                }
            }
        }
        
    }
}
