//
//  SettingsView.swift
//  Lettery
//
//  Created by Robert Clarke on 10/07/22.
//

import SwiftUI

struct SettingsView: View {
    @State var useCapitals = true
    var body: some View {
        Form {
            Section(header: Text("PREVIEW")) {
                LetterView(letter: "Y", spelling: "YES")
            }
            Toggle("Show capital letters", isOn: $useCapitals)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
