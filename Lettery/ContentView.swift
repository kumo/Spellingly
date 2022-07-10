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

extension LetteryData {
    func spellingForLetter(_ letter: String) -> String {
        let someDict:[String:String] = ["A":"Alpha", "B":"Bravo", "C":"Charlie", "D":"Delta", "E":"Echo", "F":"Foxtrot", "G":"Golf", "H":"Hotel", "I":"India", "J":"Juliett", "K":"Kilo", "L":"Lima", "M":"Mike", "N":"November", "O":"Oscar", "P":"Pap", "Q":"Quebec", "R":"Romeo", "S":"Sierra", "T":"Tango", "U":"Uniform", "V":"Victor", "W":"Whiskey", "X":"X-ray", "Y":"Yankee", "Z":"Zulu"]
        
        return someDict[letter] ?? ""
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
                        
                        if let letter = String(character.element) {
                            if let spelling = data.spellingForLetter(letter) {
                                LetterView(letter: letter, spelling: spelling)
                            }
                        }
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
