//
//  Converters.swift
//  Lettery
//
//  Created by Robert Clarke on 13/07/22.
//

import Foundation

struct Converter: Codable, Identifiable {
    
    // MARK: - Properties
    let id: UUID
    let name: String
    let author: String
    let language: String
    let startingMessage: String
    let letters: [String:String]
}

struct ConverterFile: Codable, Identifiable, Hashable {
    
    // MARK: - Properties
    let id: UUID
    let name: String
    var hidden: Bool
}

class ConverterFileDataProvider: ObservableObject {
    
    // MARK: - Propeties
    static let shared = ConverterFileDataProvider()
    private let dataSourceURL: URL
    @Published var allConverters = [ConverterFile]()
    
    // MARK: - Life Cycle
    init() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let notesPath = documentsPath.appendingPathComponent("Converters").appendingPathExtension("json")
        dataSourceURL = notesPath
        
        _allConverters = Published(wrappedValue: getAllConverters())
    }
    
    // MARK: - Methods
    private func getAllConverters() -> [ConverterFile] {
        let decoder = JSONDecoder()
        guard
            let data = try? Data(contentsOf: dataSourceURL),
            let decodedConverters = try? decoder.decode([ConverterFile].self, from: data)
        else {
            print("Couldn't load Converters from Documents")
            return getAllConvertersFromBundle()
        }
        
        return decodedConverters
    }
    
    private func getAllConvertersFromBundle() -> [ConverterFile] {
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: "Converters", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decodedConverters = try? decoder.decode([ConverterFile].self, from: data)
        else {
            print("Couldn't load Converters from Bundle")
            return []
        }
                        
        return decodedConverters
    }
    
    private func saveConverters() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(allConverters)
            try data.write(to: dataSourceURL)
        } catch {
            
        }
    }
    
    func delete(_ offsets: IndexSet) {
        offsets.forEach { index in
            allConverters[index].hidden = true
        }
        saveConverters()
    }
    
    func deleteAll() {
        allConverters.removeAll()
        saveConverters()
    }
    
    func move(source: IndexSet, destination: Int) {
        allConverters.move(fromOffsets: source, toOffset: destination)
        saveConverters()
    }
}

