import SwiftUI
import SpriteKit


struct ContentView: View {
    var body: some View {
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
