//
//  BookmarksView.swift
//  Lettery
//
//  Created by Robert Clarke on 11/07/22.
//

import SwiftUI

struct BookmarksView: View {
    // MARK: - Properties
    @ObservedObject var dataProvider = DataProvider.shared
    
    // MARK: - UI Elements
    var body: some View {
        List {
            ForEach(dataProvider.allBookmarks) { bookmark in
//                Text(bookmark.text)
                LetterGrid(
                    letters: bookmark.text.enumerated(),
                    converter: Converter(),
                    columns: Array(repeating: GridItem.init(.flexible()), count: 5))

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

//struct BookmarksView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarksView()
//    }
//}
