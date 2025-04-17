import SwiftUI
import SpriteKit


struct ContentView: View {
    var body: some View {
        
        
        
        GeometryReader{ geometry in 
            
            SpriteView(scene: FlappyFrank(size: geometry.size))

        }
        

        
        
    }
}
