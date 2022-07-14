//
//  Bookmarks.swift
//  Lettery
//
//  Created by Robert Clarke on 11/07/22.
//

import Foundation

struct BookmarkSpelling: Codable, Hashable, Identifiable {

    var id = UUID()
    let letter: String
    let spelling: String
}

struct Bookmark: Codable, Identifiable {
    
    // MARK: - Properties
    var id = UUID()
    let text: String
    let converterId: UUID
    let converterName: String
    let spellings: [BookmarkSpelling]
}

class BookmarkDataProvider: ObservableObject {
    
    // MARK: - Propeties
    static let shared = BookmarkDataProvider()
    private let dataSourceURL: URL
    @Published var allBookmarks = [Bookmark]()
    
    // MARK: - Life Cycle
    init() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let notesPath = documentsPath.appendingPathComponent("Bookmarks").appendingPathExtension("json")
        dataSourceURL = notesPath
        
        _allBookmarks = Published(wrappedValue: getAllBookmarks())
    }
    
    // MARK: - Methods
    private func getAllBookmarks() -> [Bookmark] {
        let decoder = JSONDecoder()
        guard
            let data = try? Data(contentsOf: dataSourceURL),
            let decodedBookmarks = try? decoder.decode([Bookmark].self, from: data)
        else {
            return []
        }
        
        return decodedBookmarks
    }
    
    private func saveBookmarks() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(allBookmarks)
            try data.write(to: dataSourceURL)
        } catch {
            
        }
    }
    
    func create(text: String, converter: Converter) {
        var spellings: [BookmarkSpelling] = []
        
        text.enumerated().forEach { character in
            spellings.append(BookmarkSpelling(letter: String(character.element), spelling: converter.spellingForLetter(String(character.element))))
        }

        let bookmark = Bookmark(text: text, converterId: converter.id, converterName: converter.name, spellings: spellings)

        allBookmarks.append(bookmark)
        saveBookmarks()
    }
    
    func update(bookmark: Bookmark, index: Int) {
        allBookmarks[index] = bookmark
        saveBookmarks()
    }
    
    func delete(_ offsets: IndexSet) {
        allBookmarks.remove(atOffsets: offsets)
        saveBookmarks()
    }
    
    func move(source: IndexSet, destination: Int) {
        allBookmarks.move(fromOffsets: source, toOffset: destination)
        saveBookmarks()
    }
}
