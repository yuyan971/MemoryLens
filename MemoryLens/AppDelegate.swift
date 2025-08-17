////
////  AppDelegate.swift
////  MemoryLens
////
////  Created by matt-u on 2025/08/17.
////
//
//
////func updateMenuBarItem() {
////        guard let button = statusItem?.button else { return }
////
////        if let activeApp = NSWorkspace.shared.frontmostApplication {
////            let appName = activeApp.localizedName ?? "Unknown"
////            let pid = activeApp.processIdentifier
////            let memory = getMemoryUsage(for: pid)
////
////            // メニューバーに表示
////            button.title = "\(appName): \(memory)"
////        }
////    }

//import Cocoa
import SwiftUI
//
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        PermissionChecker.requestPermissionIfNeeded()
        print(1)
    }
}
//    var statusItem: NSStatusItem?
//    var popover: NSPopover?
//    var monitor: MemMonitor?
//    var floatingWindow: NSWindow?
//
//    // アプリケーションの起動が完了したときに呼び出される．<< Start()
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        monitor = MemMonitor()
//        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        if let button = statusItem?.button {
//            button.title = "🔍"
//            button.action = #selector(togglePopover)
//            button.target = self
//        }
//        // ポップオーバーの設定
//        popover = NSPopover()
//        //popover?.contentViewController = NSHostingController(rootView: MenuView(monitor: monitor!))
//        popover?.behavior = .transient
//    }
//
//    @objc func togglePopover() {
//        if let button = statusItem?.button {
//            if popover?.isShown == true {
//                popover?.performClose(nil)
//            } else {
//                popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
//
//                // ポップオーバーのウィンドウを検出して設定を適用
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    self.setupPopoverWindow()
//                }
//            }
//        }
//    }
//
//    private func setupPopoverWindow() {
//        // ポップオーバーが表示されたら、そのウィンドウに対して設定を適用
//        if let contentView = popover?.contentViewController?.view,
//           let window = contentView.window {
//            // ウィンドウの初期設定
//            window.isMovableByWindowBackground = true
//            window.backgroundColor = NSColor.controlBackgroundColor
//        }
//    }
//
//    // アプリケーションが終了する前に呼び出される．<< OnApplicationQuit()
//    func applicationWillTerminate(_ notification: Notification) {
//        // クリーンアップ
//    }
//}
