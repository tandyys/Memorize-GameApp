//
//  MemorizeAppApp.swift
//  MemorizeApp
//
//  Created by tandyys on 07/07/24.
//

import SwiftUI
import SwiftData

@main
struct MemorizeAppApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            HomeView()
//            GrapChartView()
        }
        .modelContainer(for: GlutenData.self)
    }
}
