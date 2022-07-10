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
    @AppStorage("showCapitalsKey") var showCapitals: Bool = false
    @AppStorage("showCapitalSpellingsKey") var showCapitalSpellings: Bool = false
    @AppStorage("showSpellingOnTopKey") var showSpellingOnTop: Bool = true

    var body: some View {
        VStack {
            if !showSpellingOnTop {
                Text(showCapitals ? letter.uppercased() : letter)
                    .font(.largeTitle)
            }
            
            Text(showCapitalSpellings ? spelling.uppercased() : spelling)
                .font(.caption)
                .foregroundColor(Color("AccentColor"))
                .allowsTightening(true)
                .lineLimit(1)

            if showSpellingOnTop {
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
