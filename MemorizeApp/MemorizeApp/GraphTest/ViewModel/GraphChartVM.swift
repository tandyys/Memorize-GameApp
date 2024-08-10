//
//  GraphChartVM.swift
//  MemorizeApp
//
//  Created by tandyys on 11/07/24.
//

import Foundation
import SwiftData

class GraphChartVM: ObservableObject {
    @Published var items: [GlutenData] = [GlutenData(date: Date(), amount: 0, type: "Before eat"), GlutenData(date: Date(), amount: 0, type: "After eat")]
    private let dataSource: SwiftDataSource
    
    init(dataSource: SwiftDataSource) {
        self.dataSource = dataSource
    }
    
    func addData(_ date: Date, _ amount: Int, _ type: String) {
        let data = GlutenData(date: date, amount: amount, type: type)
        items.append(data)
        dataSource.modelContext.insert(data)
    }
    
    func removeData(_ data: GlutenData) {
        dataSource.modelContext.delete(data)
    }
}
