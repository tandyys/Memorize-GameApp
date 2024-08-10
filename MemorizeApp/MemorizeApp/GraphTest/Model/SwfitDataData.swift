//
//  SwfitDataData.swift
//  MemorizeApp
//
//  Created by tandyys on 10/07/24.
//

import Foundation
import SwiftData

@Model
class TestModel: Identifiable {
    var id = UUID()
    var glutenAmount: Int
    var type: String
    
    init(id: UUID = UUID(), glutenAmount: Int, type: String) {
        self.id = id
        self.glutenAmount = glutenAmount
        self.type = "Before eat"
    }
}
