import SwiftUI
import SpriteKit


struct ContentView: View {
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
    var scene: SKScene {
        let scene = FlappyFrank()
            scene.size = CGSize(width: 400, height: 800)
            scene.scaleMode = .resizeFill
            return scene
        }

        
}
