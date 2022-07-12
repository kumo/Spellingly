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
    let letters:[String:String]
}

struct ConverterView: View {
    @State private var converter: Converter?
    
    var body: some View {
        List {
            if let converter = converter {
                Text(converter.title)
                Text(converter.author)
                HStack {
                    Text("A")
                        .foregroundColor(.accentColor)
                    Text("for")
                    Text(converter.letters["A"] ?? "?")
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Text("B")
                        .foregroundColor(.accentColor)
                    Text("for")
                    Text(converter.letters["B"] ?? "?")
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Text("C")
                        .foregroundColor(.accentColor)
                    Text("for")
                    Text(converter.letters["C"] ?? "?")
                        .foregroundColor(.accentColor)
                }

                //                ForEach(converter.letters, id: \.self) { letter in
                //                    HStack {
                //                        Text(letter.letter)
                //                            .foregroundColor(.accentColor)
                //
                //                        Text("for")
                //
                //                        Text(letter.spelling)
                //                            .foregroundColor(.accentColor)
                //                    }
                //                }
            } else {
                Text("Couldn't load converter")
            }
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
