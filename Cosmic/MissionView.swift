//
//  MissionView.swift
//  Cosmic
//
//  Created by Caio on 10/07/24.
//

import SwiftUI

struct CrewMember {
    var role: String
    var astronaut: Astronaut
}

struct CrewButtonView: View {
    var crewMember: CrewMember
    var body: some View {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(.rect(cornerRadius: 30))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30).strokeBorder(.white, lineWidth: 2)
                    )
                
                VStack (alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    Text(crewMember.role).foregroundStyle(.white).opacity(0.5)
                }
            }
    }
}

struct MissionView: View {
    var mission: Mission
    var crew: [CrewMember]
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("\(member.name) not found")
            }
        }
    }
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            // a little bit more than half of the parent's width
                            width * 0.6
                        }
                    
                    Text(mission.longDate)
                        .padding(.top)
                        .opacity(0.6)
                    
                    Rectangle()
                        .frame(height: 11)
                        .foregroundStyle(.darkBackground)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                    }.padding(.horizontal)
                    
                    Rectangle()
                        .frame(height: 11)
                        .foregroundStyle(.darkBackground)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(crew, id: \.role) { crewMember in
                                    NavigationLink {
                                        AstronautView(astronaut: crewMember.astronaut)
                                    } label: {
                                        CrewButtonView(crewMember: crewMember)
                                    }
                                }
                            }
                        }
                    }.padding(.horizontal)
                    
                }.padding(.bottom)
            }.preferredColorScheme(.dark)
        }
        .navigationTitle(mission.displayName)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: Mission.test, astronauts: astronauts)
}
