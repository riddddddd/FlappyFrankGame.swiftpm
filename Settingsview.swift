//
//  Untitled.swift
//  Flappy Frank
//
//  Created by Alexander Kuklinski on 5/22/25.
//

import SwiftUI

struct FrankSettingsView: View {
    @AppStorage("selectedFrank") var selectedFrank: String = "Frank"
    @AppStorage("HighScore") var HighScore = 0
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
                    if HighScore >= 5{
                        Text("Blue Frank")
                        Spacer()
                        Button{ selectedFrank = "Frank1"}label: {
                            if selectedFrank == "Frank1" {
                              
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                            }
                        }
                    }else{Text("Locked: Need Highscore of 5!")
                            .opacity(0.55)
                        Spacer()
                        if selectedFrank == "Frank1" {
                            Image(systemName: "checkmark")
                        }
                    }
                
                }
                    HStack {
                        Image("Frank2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        if HighScore >= 10{
                            Text("Red Frank")
                            Spacer()
                            Button{ selectedFrank = "Frank2"}label: {
                                if selectedFrank == "Frank2" {
                                  
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.black)
                                }
                            }
                        }else{Text("Locked: Need Highscore of 10!")
                                .opacity(0.55)
                            Spacer()
                            if selectedFrank == "Frank2" {
                                Image(systemName: "checkmark")
                            }
                        }

                    }
                   
                    
                    HStack {
                        Image("Frank3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        if HighScore >= 15{
                            Text("Green Frank")
                            Spacer()
                            Button{ selectedFrank = "Frank3"}label: {
                                if selectedFrank == "Frank3" {
                                  
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.black)
                                }
                            }
                        }else{Text("Locked: Need Highscore of 15!")
                                .opacity(0.55)
                            Spacer()
                            if selectedFrank == "Frank3" {
                                Image(systemName: "checkmark")
                            }
                        }

                    }
                    
                    
                    HStack {
                        Image("Frank4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        if HighScore >= 20{
                            Text("Pink Frank")
                            Spacer()
                            Button{ selectedFrank = "Frank4"}label: {
                                if selectedFrank == "Frank4" {
                                  
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.black)
                                }
                            }
                        }else{Text("Locked: Need Highscore of 20!")
                                .opacity(0.55)
                            Spacer()
                            if selectedFrank == "Frank4" {
                                Image(systemName: "checkmark")
                            }
                        }

                    }
                    
                    
                    HStack {
                        Image("Frank5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        if HighScore >= 25{
                            Text("Gray Frank")
                            Spacer()
                            Button{ selectedFrank = "Frank5"}label: {
                                if selectedFrank == "Frank5" {
                                  
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.black)
                                }
                            }
                        }else{Text("Locked: Need Highscore of 25!")
                                .opacity(0.55)
                            Spacer()
                            if selectedFrank == "Frank5" {
                                Image(systemName: "checkmark")
                            }
                        }

                    }
                    
                    
                    HStack {
                        Image("Frank6")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        if HighScore >= 30{
                            Text("Purple Frank")
                            Spacer()
                            Button{ selectedFrank = "Frank6"}label: {
                                if selectedFrank == "Frank6" {
                                  
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.black)
                                }
                            }
                        }else{Text("Locked: Need Highscore of 30!")
                                .opacity(0.55)
                            Spacer()
                            if selectedFrank == "Frank6" {
                                Image(systemName: "checkmark")
                            }
                        }

                    }
                HStack {
                    Image("Frank7")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    if HighScore >= 50{
                        Text("Silver Frank")
                        Spacer()
                        Button{ selectedFrank = "Frank7"}label: {
                            if selectedFrank == "Frank7" {
                              
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                            }
                        }
                    }else{Text("Locked: Need Highscore of 50!")
                            .opacity(0.55)
                        Spacer()
                        if selectedFrank == "Frank7" {
                            Image(systemName: "checkmark")
                        }
                    }

                }
                HStack {
                    Image("Frank8")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    if HighScore >= 100{
                        Text("Gold Frank")
                        Spacer()
                        Button{ selectedFrank = "Frank8"}label: {
                            if selectedFrank == "Frank8" {
                              
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                            }
                        }
                    }else{Text("Locked: Need Highscore of 100!")
                            .opacity(0.55)
                        Spacer()
                        if selectedFrank == "Frank8" {
                            Image(systemName: "checkmark")
                        }
                    }

                }
                    
                }
                .navigationTitle("Select Your Frank")
                
            }
            
        }
    }
    
    
   
    

