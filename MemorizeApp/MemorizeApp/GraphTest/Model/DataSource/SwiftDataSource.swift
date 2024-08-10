//
//  SwiftDataSource.swift
//  MemorizeApp
//
//  Created by tandyys on 11/07/24.
//

import Foundation
import SwiftData

class SwiftDataSource {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataSource()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: GlutenData.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchData() -> [GlutenData] {
        do {
            return try modelContext.fetch(FetchDescriptor<GlutenData>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
