//
//  ConvertersView.swift
//  Lettery
//
//  Created by Robert Clarke on 12/07/22.
//

import SwiftUI

struct JSONData: Decodable {
    let converters: [Converter]
}

struct Converter: Decodable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let hidden: Bool
}

struct ConvertersView: View {
    @State private var converters: [Converter] = []
    
    var body: some View {
        List {
            ForEach(converters, id: \.self) { converter in
                Text(converter.name)
            }
        }
        .onAppear(perform: readFile)
    }
    
    
    private func readFile() {
        if let url = Bundle.main.url(forResource: "Converters", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
                self.converters = jsonData.converters
            }
        }
    }
}

struct ConvertersView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertersView()
    }
}
