import SwiftUI
import SpriteKit


struct ContentView: View {
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
        }
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
      
