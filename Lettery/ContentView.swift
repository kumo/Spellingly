//
//  ContentView.swift
//  Lettery
//
//  Created by Robert Clarke on 07/07/22.
//

import SwiftUI

struct LetterView: View {
    var key: String
    
    func MatchCharacter() -> String {
        if key.uppercased() == "T" {
            return "Tama"
        } else if key.uppercased() == "A" {
            return "Apple"
        } else if key.uppercased() == "M" {
            return "Monkey"
        } else if key.uppercased() == " " {
            return "Space"
        }
        
        return "Boom!"
    }
    
    var body: some View {
        VStack {
            Text(key)
                .font(.largeTitle)
            
            Text(MatchCharacter())
                .font(.caption)
        }
    }
}

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                if text.isEmpty {
                    Text("Type something")
                } else {
                    ForEach(Array(text.enumerated()), id: \.offset) { character in
                        
                        LetterView(key: String(character.element))
                    }
                }
            }
            
            Spacer()
            
            TextField("Name:", text: $text)
        }
        .padding(10.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
