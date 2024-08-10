//
//  DummyData.swift
//  MemorizeApp
//
//  Created by tandyys on 10/07/24.
//

import Foundation

struct GlutenDatas: Identifiable {
    var id = UUID().uuidString
    var amount: Int
    var type: String = "Before eat"
}

struct WeeklyData: Identifiable {
    var id = UUID().uuidString
    var date: Date
    var glutenAmount: Int
    var type: String = "Before eat"
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
