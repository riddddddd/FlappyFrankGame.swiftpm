import SwiftUI
import SpriteKit


struct ContentView: View {
    @State private var score = 0
    @State private var highScore = UserDefaults.standard.integer(forKey: "HighScore")
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
        
        Button(action: {
            score = 0
        }) {
            Text("Reset")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
            }
    
}

