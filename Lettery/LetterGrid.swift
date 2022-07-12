//
//  LetterGrid.swift
//  Lettery
//
//  Created by Robert Clarke on 10/07/22.
//

import SwiftUI

struct LetterGrid: View {
    var letters: EnumeratedSequence<String> = "".enumerated()
    var converter: Converter
    var columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 5)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10.0) {
                ForEach(Array(letters), id: \.offset) { character in
                    if let letter = String(character.element) {
                        LetterView(letter: letter, spelling: converter.letters[letter.uppercased()] ?? "")
                    }
                }
            }
        }
    }
}

//struct LetterGrid_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        LetterGrid(letters: "Foxtrot is in November".enumerated(), converter: BuiltInConverter())
//    }
//}
