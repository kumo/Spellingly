//
//  ConvertersView.swift
//  Lettery
//
//  Created by Robert Clarke on 12/07/22.
//

import SwiftUI

struct ConvertersView: View {
    
    // MARK: - Properties
    @ObservedObject var dataProvider = ConverterFileDataProvider.shared
    
    // MARK: - UI Elements
    var body: some View {
        NavigationView {
            List {
                ForEach(dataProvider.allConverters, id: \.self) { converter in
                    Text(converter.name)
                }
                .onDelete(perform: dataProvider.delete)
                .onMove(perform: dataProvider.move)
                Text("Restore converters")
                    .foregroundColor(.accentColor)
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle(Text("Converters"))
            .listStyle(InsetListStyle())
            .navigationBarItems(
                trailing: EditButton()
            )
        }
    }
}

struct ConvertersView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertersView()
    }
}
