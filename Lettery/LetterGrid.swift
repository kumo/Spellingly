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
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 10.0) {
            ForEach(Array(letters), id: \.offset) { character in
                if let letter = String(character.element) {
                    LetterView(letter: letter, spelling: Converter.spellingForLetter(letter))
                }
            }
        }
    }
}

struct LetterGrid_Previews: PreviewProvider {
    
    static var previews: some View {
        LetterGrid(letters: "Foxtrot is GoGo".enumerated(), converter: Converter())
    }
}
