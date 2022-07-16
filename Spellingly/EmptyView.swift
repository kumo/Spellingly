//
//  EmptyView.swift
//  Spellingly
//
//  Created by Robert Clarke on 16/07/22.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "bookmark.slash")
                .renderingMode(.original)
                .font(.largeTitle)
                .padding()
            Text("Save some spellings and come back here to see them...")
                .font(.title)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .padding()
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
