//
//  Color.swift
//  Cosmic
//
//  Created by Caio on 10/07/24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 18/255, green: 18/255, blue: 18/255)
    }
}

struct BackgroundView: View {
    @State var scale = 1.0
    var body: some View {
        Image("background")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .scaleEffect(scale)
        Color.black
            .opacity(0.55)
            .ignoresSafeArea().onAppear {
                withAnimation(Animation.linear(duration: 12).repeatForever()) {
                    scale = 1.2
                }
            }
    }
}
