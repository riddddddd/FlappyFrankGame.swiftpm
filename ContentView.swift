import SwiftUI
import SpriteKit


struct ContentView: View {
    @State private var score = 0
    @State private var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    @State var boolthing = false
    var body: some View {
        
        
        
        
        
        VStack{
            SpriteView(scene: scene)
                .ignoresSafeArea()
        }
        var scene: SKScene {
            let scene = FlappyFrank(size: CGSize(width: 700, height: 1000), showAlert: $boolthing)
            scene.size = CGSize(width: 200, height: 400)
            scene.scaleMode = .resizeFill
            return scene
        }
        
    }
    
}

