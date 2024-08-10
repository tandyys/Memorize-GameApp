//
//  SwiftDataVM.swift
//  MemorizeApp
//
//  Created by tandyys on 10/07/24.
//

import Foundation
import SwiftData

extension HomeView {
    func addItem(_ date: Date, _ amount: Int, _ type: String) {
        let item = GlutenData(date: date, amount: amount, type: type)
        context.insert(item)
    }
    
    func removeItem(_ data: GlutenData) {
        context.delete(data)
    }
}
