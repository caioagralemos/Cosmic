//
//  ContentView.swift
//  Cosmic
//
//  Created by Caio on 09/07/24.
//

import SwiftUI

struct Imagem: View {
    var body: some View {
        Image("Example")
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { size, axis in
                // relative to the parent component (screen size)
                size * 0.8
            }
    }
}

struct TestView: View {
    var text: String
    var body: some View {
        Text(text).font(.title)
    }
    init(text: String, number: Int) {
        print("creating view \(number)")
        self.text = text
    }
}

struct LazyView: View {
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 10) {
                ForEach(0..<100) {
                    TestView(text: "Item \($0)", number: $0)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct Navigation: View {
    var body: some View {
        NavigationView {
            List(1..<11) { row in
                NavigationLink("Number \(row)") {
                    Text("\(row)")
                }
            }
            
            
            .navigationTitle("SwiftUI")
        }
    }
}

struct Aula: View {
    let layout = [
        GridItem(.adaptive(minimum: 40))
    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("i\($0)")
                }
            }
        }
    }
}

#Preview {
    Aula()
}
