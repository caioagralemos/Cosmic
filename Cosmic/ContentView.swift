//
//  File.swift
//  Cosmic
//
//  Created by Caio on 09/07/24.
//

import Foundation
import SwiftUI

struct MissionButtonView: View {
    let mission: Mission
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .frame(width: 100, height: 100)
                .clipped()
                .padding()
            
            VStack {
                Text(mission.displayName).font(.headline).bold()
                
                Text(mission.date)
                    .font(.caption)        
                    .opacity(0.5)
                
            }.padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.darkBackground)

        }.frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: 30))
            .background(.black.opacity(0.5))
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.darkBackground, style: StrokeStyle(lineWidth: 5))
            }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    var missions: [Mission] = Bundle.main.decode("missions.json")
    @State var showList = false
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    ScrollView {
                        if showList {
                            LazyVStack(spacing: 20) {
                                ForEach (missions, id: \.self.id) { mission in
                                    NavigationLink {
                                        MissionView(mission: mission, astronauts: astronauts)
                                    } label: {
                                        HStack {
                                            Image(mission.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                            
                                            Spacer()
                                            VStack {
                                                Text(mission.displayName).font(.largeTitle).bold()
                                                
                                                Text(mission.date).foregroundStyle(.white).opacity(0.6)
                                            }
                                            
                                        }.frame(maxWidth: .infinity).padding().padding(.horizontal)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 30).stroke(lineWidth: 5).foregroundStyle(.darkBackground)
                                            }
                                    }
                                }
                            }.padding(.horizontal, 10)
                            } else {
                                LazyVGrid (columns: layout) {
                                    ForEach (missions, id: \.self.id) { mission in
                                        NavigationLink {
                                            MissionView(mission: mission, astronauts: astronauts)
                                        } label: {
                                            MissionButtonView(mission: mission)
                                        }
                                    }
                                }.padding([.horizontal, .bottom])
                            }
                    }.preferredColorScheme(.dark)
                }
            }
            .foregroundStyle(.white)
            
            .navigationTitle("Cosmic")
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        if showList {
                            Image(systemName: "square.grid.2x2")
                                .foregroundStyle(.white)
                                .opacity(0.6)
                                .onTapGesture {
                                    withAnimation {
                                        showList.toggle()
                                    }
                                }
                        } else {
                            Image(systemName: "list.bullet")
                                .foregroundStyle(.white)
                                .opacity(0.6)
                                .onTapGesture {
                                    withAnimation {
                                        showList.toggle()
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
