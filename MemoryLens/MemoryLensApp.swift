//
//  MemoryLensApp.swift
//  MemoryLens
//
//  Created by matt-u on 2025/08/17.
//

import SwiftUI

@main
struct MemoryLensApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate // これを書くことで，Awake()的なのものが使えるように．>> https://nulab.com/ja/blog/nulab/how-to-make-statusbar-app-with-swiftui/
    var body: some Scene {
        MenuBarExtra("Sample", systemImage: "graduationcap.fill"){
            MenuView()
        }
        .menuBarExtraStyle(.window)
        
    }
}
