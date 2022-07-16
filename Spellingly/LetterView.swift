//
//  LetterView.swift
//  Lettery
//
//  Created by Robert Clarke on 10/07/22.
//

import SwiftUI

struct LetterView: View {
    var letter: String
    var spelling: String
    @AppStorage("capitaliseLettersKey") var showCapitals: Bool = false
    @AppStorage("capitaliseSpellingsKey") var showCapitalSpellings: Bool = false
    @AppStorage("spellingPositionKey") var spellingPosition: SpellingPosition = .top

    var body: some View {
        VStack {
            if spellingPosition == .below {
                Text(showCapitals ? letter.uppercased() : letter)
                    .font(.largeTitle)
            }
            
            Text(showCapitalSpellings ? spelling.uppercased() : spelling)
                .font(.caption)
                .foregroundColor(Color("AccentColor"))
                .allowsTightening(true)
                .lineLimit(1)

            if spellingPosition == .top {
                Text(showCapitals ? letter.uppercased() : letter)
                    .font(.largeTitle)
            }
        }
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView(letter: "N", spelling: "November")
    }
}
