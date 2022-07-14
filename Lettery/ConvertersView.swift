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
        NavigationView {
            List {
                ForEach(Array(dataProvider.allConverters.enumerated()), id: \.element) { index, converter in
                    Button(action: {
                        converterId = converter.id.uuidString;
                    }) {

                        HStack {
                        Text(converter.name)
                        
                    if converterId == converter.id.uuidString {
                        Image(systemName: "checkmark")
                    }
                        }
                    }
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
            .toolbar {
                                Button("Done") {
                                    dismiss()
                                }
                            }
        }
    }
}

struct ConvertersView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertersView()
    }
}
