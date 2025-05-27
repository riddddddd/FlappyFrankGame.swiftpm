//
//  Untitled.swift
//  Flappy Frank
//
//  Created by Alexander Kuklinski on 5/22/25.
//

import SwiftUI

struct FrankSettingsView: View {
    @AppStorage("selectedFrank") private var selectedFrank: String = "Frank"
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image("Frank")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Classic Frank")
                    Spacer()
                    if selectedFrank == "Frank" {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFrank = "Frank"
                }

                HStack {
                    Image("Frank1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Blue Frank")
                    Spacer()
                    if selectedFrank == "Frank1" {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFrank = "Frank1"
                }

                HStack {
                    Image("Frank2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Red Frank")
                    Spacer()
                    if selectedFrank == "Frank2" {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFrank = "Frank2"
                }

                HStack {
                    Image("Frank3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Green Frank")
                    Spacer()
                    if selectedFrank == "Frank3" {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFrank = "Frank3"
                }

                HStack {
                    Image("Frank4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Pink Frank")
                    Spacer()
                    if selectedFrank == "Frank4" {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFrank = "Frank4"
                }

                HStack {
                    Image("Frank5")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Gray Frank")
                    Spacer()
                    if selectedFrank == "Frank5" {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFrank = "Frank5"
                }

                HStack {
                    Image("Frank6")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Purple Frank")
                    Spacer()
                    if selectedFrank == "Frank6" {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFrank = "Frank6"
                }
            }
            .navigationTitle("Select Your Frank")
            
        }
        
        }
    }


#Preview {
    FrankSettingsView()
}

