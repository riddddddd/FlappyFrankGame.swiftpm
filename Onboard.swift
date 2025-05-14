//
//  Onboard.swift
//  FlappyFrankGame
//
//  Created by Riddick R. Variano on 5/6/25.
//
import SwiftUI

struct Onboard: View {
    
    @AppStorage("Onboarded") private var Onboarded = false
    
    var body: some View {
        VStack{
            Text("Flappy Frank")
                .font(.custom("", size: 60))
            Image("Frank")
                .resizable()
                .frame(width: 902/5, height: 636/5)
                .padding()
            TabView{
                V1()
                V2()
                V3()
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))

        }
        .background{
            
        }
    }
}
#Preview {
    Onboard()
}
struct V3: View {
    @AppStorage("Onboarded") private var Onboarded = false

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.cyan.gradient)
            VStack{
                Text("Fly as far as you can!")
                    .font(.title)
                Button{
                    Onboarded = true
                }label: {
                    Image("start")
                        .resizable()
                }
                .padding()
                .frame(width: 400, height: 200)
            }
            .foregroundStyle(.white)
        }.frame(width: 300, height: 300)
    }
}
struct V1: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.cyan.gradient)
            VStack{
                Text("Tap to jump")
                    .font(.title)
                HStack{
                    Image("Frank")
                        .resizable()
                        .frame(width: 902/8, height: 636/8)
                        .rotationEffect(Angle(degrees: -45))
                        .padding()
                }
                Text("Don't hit the ground!")
            }
            .foregroundStyle(.white)
        }.frame(width: 300, height: 300)
    }
}
struct V2: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.cyan.gradient)
            VStack{
                Text("Dodge Obstacles!")
                    .font(.title)
                Image("bottomPipe")
                    
            }
            .foregroundStyle(.white)
        }.frame(width: 300, height: 300)
    }
}
