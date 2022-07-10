//
//  ContentView.swift
//  Lettery
//
//  Created by Robert Clarke on 07/07/22.
//

import SwiftUI

class LetteryData: ObservableObject {
    @Published var input = "" {
        didSet {
            // TODO: add support for an uppercase setting
            cleanedInput = input.uppercased().enumerated()
            // TODO: add support for word wrapping and setting
        }
    }
    @Published var cleanedInput = "".enumerated()
}

struct LetterView: View {
    var key: String
    
    func MatchCharacter() -> String {
        if key.uppercased() == "F" {
            return "Foxtrot"
        } else if key.uppercased() == "O" {
            return "Oscar"
        } else if key.uppercased() == "X" {
            return "X-Ray"
        } else if key.uppercased() == "T" {
            return "Tango"
        } else if key.uppercased() == "R" {
            return "Romeo"
        }
        
        return ""
    }
    
    var body: some View {
        VStack {
            Text(MatchCharacter())
                .font(.caption)
                .foregroundColor(Color("AccentColor"))
            
            Text(key)
                .font(.largeTitle)
        }
    }
}

struct ContentView: View {
    @StateObject var data = LetteryData()
    @FocusState private var isFocused: Bool
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        VStack {
            Spacer()
            
            if data.input.isEmpty {
                Text("Type something")
            } else {
                LazyVGrid(columns: columns, alignment: .center, spacing: 10.0) {
                    ForEach(Array(data.cleanedInput), id: \.offset) { character in
                        
                        LetterView(key: String(character.element))
                    }
                }
            }
            
            Spacer()
            
            TextField("Name:", text: $data.input)
                .focused($isFocused, equals: true)
                          .onAppear {
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ self.isFocused = true }
                            
                        }
        }
        .padding(10.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
