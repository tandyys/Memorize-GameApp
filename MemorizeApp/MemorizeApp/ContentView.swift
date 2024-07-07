//
//  ContentView.swift
//  MemorizeApp
//
//  Created by tandyys on 07/07/24.
//

import SwiftUI

struct ContentView: View {
    
    let emojis:[String] = ["🍎", "💀", "👾", "🪼", "🐊", "🧟", "🧸", "🦠"]
    @State var cardCount: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index])
                }
            }
            .foregroundColor(.red)
            .padding()
            HStack(alignment: .center, content: {
                Button(action: {
                    if cardCount < emojis.count {
                        cardCount+=1
                    }
                }, label: {
                    Image(systemName: "plus.rectangle")
                })
                Spacer()
                Button(action: {
                    if cardCount > 1 {
                        cardCount-=1
                    }
                }, label: {
                    Image(systemName: "minus.rectangle")
                })
            })
            .foregroundColor(.red)
            .imageScale(.large)
            .font(.largeTitle)
        }
        .padding()
    }
    
}

struct CardView: View {
    
    var content:String
    @State var isFaceUp:Bool = false
    
    var body: some View {
        ZStack {
            var baseCard: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                baseCard.fill(.white)
                baseCard.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                baseCard.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
            print(isFaceUp)
        }
    }
    
}

#Preview {
    ContentView()
}
