//
//  ConverterView.swift
//  Lettery
//
//  Created by Robert Clarke on 12/07/22.
//

import SwiftUI

struct Converter: Decodable, Identifiable {
    let id: UUID
    let title: String
    let author: String
    let language: String
    let letters: [String:String]
}

struct ConverterView: View {
    @State private var converter: Converter?
    @StateObject var data = LetteryData()
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationView {
            VStack {
                if let converter = converter {
                    LetterGrid(letters: data.cleanedInput, converter: converter)
                } else {
                    Text("No working converter")
                }
                
                TextField("Type something", text: $data.input)
                    .focused($isFocused, equals: true)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ self.isFocused = true }
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text(converter?.title ?? "unknown").font(.headline)
                                .onTapGesture {
                                    print("Navigation title pressed...")
                                }
                        }
                    }
            }
            .padding(10.0)
        }
        .onAppear(perform: readFile)

   
    }
    
    private func readFile() {
        // TODO: Check if the file is in the document directory, and if it isn't, get it from the bundle
        if let url = Bundle.main.url(forResource: "NATO", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(Converter.self, from: data) {
                self.converter = jsonData
            } else {
                print("Couldn't decode file")
            }
        }
        
        //        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        //            let fileUrl = documentsDirectory.appendingPathComponent("NATO.json")
        //            if let data = try? Data(contentsOf: fileUrl) {
        //                let decoder = JSONDecoder()
        //                if let jsonData = try? decoder.decode(Converter.self, from: data) {
        //                    self.converter = jsonData
        //                }
        //            }
        //        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
