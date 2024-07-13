//
//  Mission.swift
//  Cosmic
//
//  Created by Caio on 09/07/24.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    static var test: Mission = Mission(id: 3, crew: [CrewMember(name: "white", role: "CEO"), CrewMember(name: "chaffee", role: "Front-end"), CrewMember(name: "grissom", role: "Back-end")], description: "lorem ipsum dolor sit amet, When the user selects one of the Apollo missions from our main list, we want to show information about the mission: its mission badge, its mission description, and all the astronauts that were on the crew along with their roles. The first two of those aren’t too hard, but the third requires a little more work because we need to match up crew IDs with crew details across our two JSON files.")
    
    struct CrewMember: Codable, Hashable {
        var name: String
        var role: String
    }
    
    var id: Int
    var launchDate: Date?
    var crew: [CrewMember]
    var description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var date: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var longDate: String {
        launchDate?.formatted(date: .long, time: .omitted) ?? "N/A"
    }
    
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        lhs.displayName == rhs.displayName && lhs.description == rhs.description && lhs.launchDate == rhs.launchDate
    }
}
