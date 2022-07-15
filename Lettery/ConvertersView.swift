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
    
    // MARK: - UI Elements
    var body: some View {
        List {
            Section {
                ForEach(Array(dataProvider.allConverters.enumerated()), id: \.element) { index, converter in
                    VStack {
                        HStack {
                            Text(converter.name)
                            
                            Spacer()
//
//                            Button(action: {}) {
//                                Image(systemName: "info.circle")
//                            }
//                            .foregroundColor(.accentColor)
                        }
                        if let comment = converter.comment {
                            HStack {
                                Text(comment)
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                }
                .onDelete(perform: dataProvider.delete)
                .onMove(perform: dataProvider.move)
            } footer: {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        dataProvider.restoreConverters()
                    }) {
                        Text("Restore converters")
                            .font(.footnote)
                    }

                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle(Text("Converters"))
        .navigationBarItems(
            trailing: EditButton()
        )
    }
}

struct ConvertersView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertersView()
    }
}
