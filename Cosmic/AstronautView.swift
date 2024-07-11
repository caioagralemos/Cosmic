//
//  AstronautView.swift
//  Cosmic
//
//  Created by Caio on 10/07/24.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                    Text(astronaut.description)
                        .foregroundStyle(.white).padding()
                }
            }
        }
        .navigationTitle(astronaut.name)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronauts["chaffee"]!)
}
