//
//  BookmarksView.swift
//  Lettery
//
//  Created by Robert Clarke on 11/07/22.
//

import SwiftUI

struct BookmarksView: View {
    // MARK: - Properties
    @ObservedObject var dataProvider = BookmarkDataProvider.shared
    @AppStorage("capitaliseSpellingsKey") var capitaliseSpellings: Bool = false

    // MARK: - UI Elements
    var body: some View {
        if dataProvider.allBookmarks.isEmpty {
            EmptyView(icon: "bookmark.slash", title: "Save some spellings and come back here to see them...")
        } else {
            List {
                ForEach(dataProvider.allBookmarks) { bookmark in
                    if let preferredColumns = bookmark.preferredColumns {
                        BookmarkGrid(bookmark: bookmark, columns: Array(repeating: .init(.flexible()), count: (capitaliseSpellings ? preferredColumns - 1 : preferredColumns)))
                    } else {
                        BookmarkGrid(bookmark: bookmark)
                    }
                    //                Text(bookmark.text)
                    //                LetterGrid(
                    //                    letters: bookmark.text.enumerated(),
                    //                    converter: BuiltInConverter(),
                    //                    columns: Array(repeating: GridItem.init(.flexible()), count: 5))
                    
                }
                .onDelete(perform: dataProvider.delete)
                .onMove(perform: dataProvider.move)
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle(Text("Bookmarks"))
            .listStyle(InsetListStyle())
            .navigationBarItems(
                trailing: EditButton()
            )
        }
    }
}

//struct BookmarksView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarksView()
//    }
//}
