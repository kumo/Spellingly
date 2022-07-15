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
    let startingMessage: String?
    let preferredColumns: Int?
    let spellings: [String:String]
}

extension Converter {
    func spellingForLetter(_ letter: String) -> String {
        // let someDict:[String:String] = ["A":"Alpha", "B":"Bravo", "C":"Charlie", "D":"Delta", "E":"Echo", "F":"Foxtrot", "G":"Golf", "H":"Hotel", "I":"India", "J":"Juliett", "K":"Kilo", "L":"Lima", "M":"Mike", "N":"November", "O":"Oscar", "P":"Papa", "Q":"Quebec", "R":"Romeo", "S":"Sierra", "T":"Tango", "U":"Uniform", "V":"Victor", "W":"Whiskey", "X":"X-ray", "Y":"Yankee", "Z":"Zulu"]
        
        return spellings[letter.uppercased()] ?? ""
    }

}

struct ConverterFile: Codable, Identifiable, Hashable {
    
    // MARK: - Properties
    let id: UUID
    let name: String
    let included: Bool
    let comment: String?
}

class ConverterDataProvider: ObservableObject {
    
    // MARK: - Propeties
    static let shared = ConverterDataProvider()
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
//        offsets.forEach { index in
//            allConverters[index].hidden = true
//        }
        allConverters.remove(atOffsets: offsets)
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

extension ConverterDataProvider {
    func loadConverter(_ converter: ConverterFile) -> Converter? {
        // TODO: Check if the file is in the document directory, and if it isn't, get it from the bundle
        if let url = Bundle.main.url(forResource: converter.name, withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(Converter.self, from: data) {
                return jsonData
            } else {
                print("Couldn't decode file")
            }
        }
        
        return nil
    }
    
    func loadConverterById(_ id: UUID) -> Converter? {
        guard let converter = allConverters.first(where: { $0.id == id}) else {
            return ConverterDataProvider.loadDefaultConverter()
        }
        
        return loadConverter(converter)
    }
}

extension ConverterDataProvider {
    static func loadDefaultConverter() -> Converter {
        let url = Bundle.main.url(forResource: "NATO", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonData = try! decoder.decode(Converter.self, from: data)
        
        return jsonData
    }
}

extension ConverterDataProvider {
    func restoreConverters() {
        allConverters = getAllConvertersFromBundle()
        saveConverters()
    }
}
