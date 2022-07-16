//
//  ConvertersView.swift
//  Lettery
//
//  Created by Robert Clarke on 12/07/22.
//

import SwiftUI

struct ConvertersView: View {
    
    // MARK: - Properties
    @ObservedObject var dataProvider = ConverterDataProvider.shared
    @AppStorage("converterIdKey") var converterId: String = ""
    @Environment(\.dismiss) var dismiss
    @State var editMode: EditMode = .inactive
    
    // MARK: - UI Elements
    var body: some View {
        List {
            Section {
                ForEach(Array(dataProvider.allConverters.enumerated()), id: \.element) { index, converter in
                    VStack {
                        Text(converter.name)
                            .font(.title2)

                        LetterGrid(
                            letters: converter.name.enumerated(),
                            converter: ConverterDataProvider.loadConverter(converter)!,
                            columns: Array(repeating: GridItem.init(.flexible()), count: 4))

                        if let comment = converter.comment {
                            HStack {
                                Text(comment)
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                              //  Spacer()
                            }
                        }
                    }
                }
                .onDelete(perform: dataProvider.delete)
                .onMove(perform: dataProvider.move)
            }
        }
        .listStyle(InsetListStyle())
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle(Text("Converters"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {dataProvider.restoreConverters()}) {
                    Text("Reset")
                }
                            }
            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
        }
    }
}

struct ConvertersView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertersView()
    }
}
