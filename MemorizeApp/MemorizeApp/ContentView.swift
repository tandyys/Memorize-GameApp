//
//  ContentView.swift
//  MemorizeApp
//
//  Created by tandyys on 07/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CardView(isFaceUp: true)
            CardView()
        }
        .foregroundColor(.orange)
        .font(.largeTitle)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp:Bool = false
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12).foregroundStyle(Color.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 3)
                Text("🍎")
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}

#Preview {
    ContentView()
}
