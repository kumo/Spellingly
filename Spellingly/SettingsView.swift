//
//  SettingsView.swift
//  Lettery
//
//  Created by Robert Clarke on 10/07/22.
//

import SwiftUI

enum SpellingPosition: String, CaseIterable, Identifiable {
    case top
    case below
    
    var id: SpellingPosition { self }
}

struct SettingsView: View {

    // MARK: - Properties
    @AppStorage("capitaliseLettersKey") var capitaliseLetters: Bool = false
    @AppStorage("capitaliseSpellingsKey") var capitaliseSpellings: Bool = false
    @AppStorage("spellingPositionKey") var spellingPosition: SpellingPosition = .top
//    @AppStorage("removeLeadingSpacesKey") var removeLeadingSpace: Bool = false
//    @AppStorage("removeTrailingLettersKey") var startOnNewLine: Bool = false
//    @AppStorage("converterNameKey") var converterName: String = "NATO"
    @State private var converter: Converter = ConverterDataProvider.loadDefaultConverter()

    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preview - \(converter.name)")) {
                    if let converter = converter {
                        LetterGrid(
                            letters: "Then to now".enumerated(),
                            converter: converter,
                            columns: Array(repeating: GridItem.init(.flexible()), count: 4))
                    }
                }
                .navigationTitle("Spellingly")
                
                Section(header: Text("Options")) {
                    Picker("Spelling position", selection: $spellingPosition ) {
                        ForEach(SpellingPosition.allCases, content: { position in
                            Text(position.rawValue.capitalized)
                        })
                    }
                    Toggle("Capitalise letters", isOn: $capitaliseLetters)
                    Toggle("Capitalise spellings", isOn: $capitaliseSpellings)
//                    Toggle("Remove leading spaces", isOn: $removeLeadingSpace)
//                        .disabled(true)
//                    Toggle("Start words on a new line", isOn: $startOnNewLine)
//                        .disabled(true)
                }
                
                Section(header: Text("About"), footer: Text("Version 1.0.0")) {
                    Label("Tip Jar", systemImage: "heart.text.square.fill")
                        .disabled(true)
                    NavigationLink {
                        BookmarksView()
                    } label: {
                        Label("Bookmarks", systemImage: "bookmark.circle.fill")
                    }
                    NavigationLink {
                        ConvertersView()
                    } label: {
                        Label("Converters", systemImage: "abc")
                    }
                    Label("Support", systemImage: "link.circle.fill")
                        .disabled(true)
                }
            }
        }
//        .onAppear(perform: loadConverter)
    }
    
//    private func loadConverter() {
//        // TODO: Check if the file is in the document directory, and if it isn't, get it from the bundle
//        if let url = Bundle.main.url(forResource: converterName, withExtension: "json"),
//           let data = try? Data(contentsOf: url) {
//            let decoder = JSONDecoder()
//            if let jsonData = try? decoder.decode(Converter.self, from: data) {
//                self.converter = jsonData
//            } else {
//                print("Couldn't decode file")
//            }
//        }
//    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
