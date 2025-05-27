import SwiftUI

@main
struct MyApp: App {
    
    @AppStorage("Onboarded") var Onboarded = false
    
    var body: some Scene {
        
        WindowGroup {
            if Onboarded{
                
                ContentView()

                
            }else{
                
                Onboard()
                
            }

            
            
            
        }
    }
}
