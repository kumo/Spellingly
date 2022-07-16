//
//  EmptyView.swift
//  Spellingly
//
//  Created by Robert Clarke on 16/07/22.
//

import SwiftUI

struct EmptyView: View {

    // MARK: - Properties
    var icon: String
    var title: String

    
    // MARK: - UI Elements
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: icon)
                .renderingMode(.original)
                .font(.largeTitle)
                .padding()
            Text(title)
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
        EmptyView(icon: "eye.trianglebadge.exclamationmark.fill", title: "Not much to see here. Perhaps you should look over there..")
    }
}
