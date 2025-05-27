import SwiftUI
import SpriteKit


struct ContentView: View {
    @State var score = 0
    @State var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    @State var boolthing = false
    var body: some View {
        
        
        
        
        
        VStack{
            SpriteView(scene: scene)
                .ignoresSafeArea()
        }
        var scene: SKScene {
            let scene = FlappyFrank()
            scene.size = CGSize(width: 200, height: 400)
            scene.scaleMode = .resizeFill
            return scene
        }
        
    }
    
}

