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
            cleanedInput = input.enumerated()
            // TODO: add support for word wrapping and setting
        }
    }
    @Published var cleanedInput = "Type your text.".enumerated()
    @Published var converter: Converter?
}

class BuiltInConverter {
    static func spellingForLetter(_ letter: String) -> String {
        let someDict:[String:String] = ["A":"Alpha", "B":"Bravo", "C":"Charlie", "D":"Delta", "E":"Echo", "F":"Foxtrot", "G":"Golf", "H":"Hotel", "I":"India", "J":"Juliett", "K":"Kilo", "L":"Lima", "M":"Mike", "N":"November", "O":"Oscar", "P":"Papa", "Q":"Quebec", "R":"Romeo", "S":"Sierra", "T":"Tango", "U":"Uniform", "V":"Victor", "W":"Whiskey", "X":"X-ray", "Y":"Yankee", "Z":"Zulu"]
        
        return someDict[letter.uppercased()] ?? ""
    }
}

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var data = LetteryData()
    @FocusState private var isFocused: Bool
    @State var showSettingsView = false
    @State var showConvertersView = false
    @ObservedObject var dataProvider = BookmarkDataProvider.shared
    @AppStorage("converterNameKey") var converterName: String = "NATO"
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            VStack {
                if let converter = data.converter {
                    LetterGrid(letters: data.cleanedInput, converter: converter)
                } else {
                    Text("No converter loaded.")
                }
                
                TextField("Type something", text: $data.input)
                    .focused($isFocused, equals: true)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ self.isFocused = true }
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text(data.converter?.name ?? "Unknown").font(.headline)
                                .onTapGesture {
                                    print("Navigation title pressed...")
                                    self.showConvertersView.toggle()
                                }
                                .sheet(isPresented: $showConvertersView) {
                                    ConvertersView()
                                }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu(content: {
                                Button(action: {}) {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                if dataProvider.allBookmarks.firstIndex { $0.text == data.input} != nil {
                                    Label("Saved", systemImage: "bookmark.fill")
                                } else {
                                    Button(action: {
                                        let bookmark = Bookmark(text: data.input, converter: converterName)
                                        
                                        BookmarkDataProvider.shared.create(bookmark: bookmark)
                                    }) {
                                        Label("Save", systemImage: "bookmark")
                                    }
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
        .onAppear(perform: loadConverter)
    }
    
    private func loadConverter() {
        // TODO: Check if the file is in the document directory, and if it isn't, get it from the bundle
        if let url = Bundle.main.url(forResource: converterName, withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(Converter.self, from: data) {
                self.data.converter = jsonData
                self.data.cleanedInput = jsonData.startingMessage.enumerated()
            } else {
                print("Couldn't decode file")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
