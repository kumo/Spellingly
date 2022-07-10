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
    @Published var cleanedInput = "TYPE YOUR TEXT.".enumerated()
}

class Converter {
    static func spellingForLetter(_ letter: String) -> String {
        let someDict:[String:String] = ["A":"Alpha", "B":"Bravo", "C":"Charlie", "D":"Delta", "E":"Echo", "F":"Foxtrot", "G":"Golf", "H":"Hotel", "I":"India", "J":"Juliett", "K":"Kilo", "L":"Lima", "M":"Mike", "N":"November", "O":"Oscar", "P":"Papa", "Q":"Quebec", "R":"Romeo", "S":"Sierra", "T":"Tango", "U":"Uniform", "V":"Victor", "W":"Whiskey", "X":"X-ray", "Y":"Yankee", "Z":"Zulu"]
        
        return someDict[letter.uppercased()] ?? ""
    }
}

struct ContentView: View {
    @StateObject var data = LetteryData()
    @FocusState private var isFocused: Bool
    @State var showSettingsView = false
    
    var body: some View {
        NavigationView {
            VStack {
                LetterGrid(letters: data.cleanedInput, converter: Converter())
                
                TextField("Type something", text: $data.input)
                    .focused($isFocused, equals: true)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ self.isFocused = true }
                        
                    }
                    .navigationBarTitle("NATO",  displayMode: .inline)
                    .onTapGesture {
                        print("Navigation title pressed...")
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu(content: {
                                Button(action: {}) {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                Button(action: {}) {
                                    Label("Save", systemImage: "bookmark")
                                }
                                
                            }, label: {Image(systemName: "ellipsis.circle").imageScale(.large)})
                        }
                    }
                    .navigationBarItems(leading:
                                            Button(action: {
                        print("Settings button pressed...")
                        self.showSettingsView.toggle()
                    }) {
                        Image(systemName: "gearshape").imageScale(.large)
                    }
                        .sheet(isPresented: $showSettingsView) {
                            SettingsView()
                        }
                    )
            }
            .padding(10.0)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
