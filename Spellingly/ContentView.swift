//
//  ContentView.swift
//  Lettery
//
//  Created by Robert Clarke on 07/07/22.
//

import SwiftUI
import StoreKit

class LetteryData: ObservableObject {
    @Published var input = "" {
        didSet {
            // TODO: add support for an uppercase setting
            cleanedInput = input.enumerated()
            // TODO: add support for word wrapping and setting
        }
    }
    @Published var cleanedInput = "".enumerated()
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
    @State private var selectedItem: String = ""
    // MARK: - User Settings
    @AppStorage("converterIdKey") var converterId: String = ""
    @AppStorage("capitaliseSpellingsKey") var capitaliseSpellings: Bool = false
    @AppStorage("review.counter") private var reviewCounter = 0

    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            VStack {
                if let preferredColumns = data.converter.preferredColumns {
                    // FIXME: Rewrite this
                    LetterGrid(letters: data.cleanedInput, converter: data.converter, columns: Array(repeating: .init(.flexible()), count: (capitaliseSpellings ? preferredColumns - 1 : preferredColumns)))
                } else {
                    LetterGrid(letters: data.cleanedInput, converter: data.converter)
                }

                TextField("Type something", text: $data.input)
                    .focused($isFocused, equals: true)
                    .onTapGesture {
                        self.isFocused = true
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ self.isFocused = true }
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            // FIXME: Ensure that the title width is adjusted
                            Picker("Converter", selection: $selectedItem) {
                                ForEach(Array(converterDataProvider.allConverters.enumerated()), id: \.element) { index, item in
                                    Text(item.name).tag(item.id.uuidString)
                                }
                            }
                            .onChange(of: selectedItem) { tag in print("Converter ID: \(tag)")
                                converterId = selectedItem
                                loadConverter()
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu(content: {
                                Button(action: {}) {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                
                                if dataProvider.allBookmarks.firstIndex { $0.text == data.input && $0.converterId == data.converter.id } != nil {
                                    Label("Saved", systemImage: "bookmark.fill")
                                } else {
                                    Button(action: {
                                        BookmarkDataProvider.shared.create(text: data.input, converter: data.converter)
                                    }) {
                                        Label("Save", systemImage: "bookmark")
                                    }
                                }
                                
                                Picker("Converter", selection: $selectedItem) {
                                    ForEach(Array(converterDataProvider.allConverters.enumerated()), id: \.element) { index, item in
                                        Text(item.name).tag(item.id.uuidString)
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
        .onAppear {
            loadConverter()
            
            reviewCounter += 1
            
            if (reviewCounter > 10) {
                let scenes = UIApplication.shared.connectedScenes
                if let windowScene = scenes.first as? UIWindowScene {
                    reviewCounter = 0
                    SKStoreReviewController.requestReview(in: windowScene)
                }
            }
        }
    }
    
    private func loadConverter() {
        // TODO: Make the ConverterDataProvider be responsible for this edge case
        if let uuid = UUID(uuidString: converterId),
              let converter = converterDataProvider.loadConverterById(uuid) {
            self.data.converter = converter
        } else {
            print("No converter specified. Loading default")
            self.data.converter = ConverterDataProvider.loadDefaultConverter()
            converterId = self.data.converter.id.uuidString
        }
        
        if data.input.isEmpty {
            if let startingMessage = self.data.converter.startingMessage {
                data.cleanedInput = startingMessage.enumerated()
            } else {
                data.cleanedInput = "Type your text.".enumerated()
            }
        }
        
        selectedItem = converterId
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
