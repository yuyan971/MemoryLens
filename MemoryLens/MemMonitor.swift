////
////  MemoryMonitor.swift
////  MemoryLens
////
////  Created by matt-u on 2025/08/17.
////
//
//import SwiftUI
//
//class MemMonitor: ObservableObject {
//    var appName = "取得中..."
//    var memoryUsage = "計測中..."
//    var refreshInterval: TimeInterval = 1.0 {
//        didSet {
//            restartTimer()
//        }
//    }
//    
//    private var timer: Timer?
//    
//    init() {
//        updateInfo()
//        restartTimer()
//    }
//    
//    private func restartTimer() {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true) { _ in
//            self.updateInfo()
//        }
//    }
//    
//    private func updateInfo() {
//        if let activeApp = NSWorkspace.shared.frontmostApplication {
//            appName = activeApp.localizedName ?? "Unknown"
//            let pid = activeApp.processIdentifier
//            memoryUsage = getMemoryUsage(for: pid)
//        }
//    }
//    
//    private func getMemoryUsage(for pid: pid_t) -> String {
//        var info = proc_taskinfo()
//        let size = Int32(MemoryLayout<proc_taskinfo>.size)
//        
//        let result = proc_pidinfo(pid, PROC_PIDTASKINFO, 0, &info, size)
//        
//        if result == size {
//            let memoryMB = Double(info.pti_resident_size) / 1024.0 / 1024.0
//            
//            if memoryMB < 1024 {
//                return String(format: "%.0f MB", memoryMB)
//            } else {
//                let memoryGB = memoryMB / 1024.0
//                return String(format: "%.1f GB", memoryGB)
//            }
//        }
//        
//        return "N/A"
//    }
//    
//    deinit {
//        timer?.invalidate()
//    }
//}
