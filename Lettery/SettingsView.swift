//
//  SettingsView.swift
//  Lettery
//
//  Created by Robert Clarke on 10/07/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("showCapitalsKey") var showCapitals: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Preview")) {
                LetterGrid(
                    letters: "Here and now".enumerated(),
                    converter: Converter(),
                    columns: Array(repeating: GridItem.init(.flexible()), count: 4))
            }
            Section(header: Text("Options")) {
                Toggle("Show capital letters", isOn: $showCapitals)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
