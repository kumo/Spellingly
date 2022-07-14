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
    @Published var converter: Converter = ConverterDataProvider.loadDefaultConverter()
}

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var data = LetteryData()
    @FocusState private var isFocused: Bool
    @State var showSettingsView = false
    @State var showConvertersView = false
    @ObservedObject var dataProvider = BookmarkDataProvider.shared
    @ObservedObject var converterDataProvider = ConverterDataProvider.shared
    @AppStorage("converterIdKey") var converterId: String = ""
        
    
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
                            // FIXME: Ensure that the title width is adjusted
                            Text(data.converter.name).font(.headline)
                                .onTapGesture {
                                    print("Navigation title pressed...")
                                    self.showConvertersView.toggle()
                                }
                                .sheet(isPresented: $showConvertersView,
                                       onDismiss: loadConverter) {
                                    ConvertersView()
                                }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu(content: {
                                Button(action: {}) {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                if dataProvider.allBookmarks.firstIndex { $0.text == data.input && $0.converter == data.converter.name } != nil {
                                    Label("Saved", systemImage: "bookmark.fill")
                                } else {
                                    Button(action: {
                                        let bookmark = Bookmark(text: data.input, converter: data.converter.name)
                                        
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
        // TODO: Make the ConverterDataProvider be responsible for this edge case
        guard let uuid = UUID(uuidString: converterId),
              let converter = converterDataProvider.loadConverterById(uuid)
        else {
            print("No converter specified. Loading default")
            self.data.converter = ConverterDataProvider.loadDefaultConverter()
            converterId = self.data.converter.id.uuidString
            
            return
        }
        
        self.data.converter = converter
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
