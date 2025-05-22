//
//  Onboard.swift
//  FlappyFrankGame
//
//  Created by Riddick R. Variano on 5/6/25.
//
import SwiftUI

struct Onboard: View {
    
    @AppStorage("Onboarded") private var Onboarded = false
    @State private var float = false
    
    var body: some View {
        VStack{
            Text("Flappy Frank")
                .font(.custom("PixelFontName", size: 60))
                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 4)
                .padding(.top, 40)
            Image("Frank")
                .resizable()
                .frame(width: 902/5, height: 636/5)
                .padding()
                .offset(y: float ? -10: 10)
                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: float)
                .onAppear {
                    float = true
                }
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
@State private var pressed = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.cyan.gradient)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 8)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                         )
            VStack{
                Text("Fly as far as you can!")
                    .font(.title)
                Button{
                    Onboarded = true
                }label: {
                    Image("start")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 100)
                        .shadow(radius: 10)
                        .scaleEffect(pressed ? 0.95 : 1.0)
                        .animation(.spring(), value: pressed)
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
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 8)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                         )
            VStack{
                Text("Tap to jump")
                    .font(.title)
                    .bold()
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
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 8)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                         )
            VStack{
                Text("Dodge Obstacles!")
                    .font(.title)
                Image("bottomPipe")
                    
            }
            .foregroundStyle(.white)
        }.frame(width: 300, height: 300)
    }
}
