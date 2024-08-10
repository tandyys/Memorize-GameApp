//
//  GlutenData.swift
//  MemorizeApp
//
//  Created by tandyys on 10/07/24.
//

import Foundation
import SwiftData

@Model
class GlutenData: Identifiable {
    var id = UUID().uuidString
    var date: Date = Date()
    var amount: Int
    var type: String = "Before eat"
    var mmolAmount: Double {
        return Double(amount / 18)
    }
    
    init(id: String = UUID().uuidString, date: Date, amount: Int, type: String) {
        self.id = id
        self.date = date
        self.amount = amount
        self.type = type
    }
}
