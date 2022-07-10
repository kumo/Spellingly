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

    var body: some View {
        VStack {
            Text(spelling)
                .font(.footnote)
                .foregroundColor(Color("AccentColor"))
                .allowsTightening(true)
                .lineLimit(1)
            
            Text(showCapitals ? letter.uppercased() : letter)
                .font(.largeTitle)
        }
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView(letter: "N", spelling: "November")
    }
}
