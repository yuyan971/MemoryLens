//
//  MemoryLensApp.swift
//  MemoryLens
//
//  Created by matt-u on 2025/08/17.
//

import SwiftUI

@main
struct MemoryLensApp: App {
    var body: some Scene {
        MenuBarExtra("Sample", systemImage: "circle.fill"){
            MenuView()
        }
        //.menuBarExtraStyle(.window)
        
    }
}
