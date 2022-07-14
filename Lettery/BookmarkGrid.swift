//
//  BookmarkGrid.swift
//  Lettery
//
//  Created by Robert Clarke on 14/07/22.
//

import SwiftUI

struct BookmarkGrid: View {
    var bookmark:Bookmark
    var columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 5)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10.0) {
                ForEach(bookmark.spellings) { element in
                    LetterView(letter: element.letter, spelling: element.spelling)
                }
            }
        }
    }
}
