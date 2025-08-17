//
//  MenuView.swift
//  MemoryLens
//
//  Created by matt-u on 2025/08/17.
//

import SwiftUI
import Cocoa  // NSWorkspace用
import Darwin  // proc_pidinfo用

struct MenuView: View {
    //    @State var btnTxt = "Button"
    @State var memoryInfo = "計測中..."
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) { // 縦に並べる(なければ上書き?)
            Text(memoryInfo)
                .font(.system(.body, design: .monospaced))
                .padding(.horizontal)
            
            Divider()
            
            //            Button(action: {
            //                updateTxt()
            //                btnTxt = "更新しました!"
            //            }) {
            //                Text(btnTxt)
            //            }
            //            .padding(.horizontal)
            
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                Text("終了")
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .frame(width: 250)
        .onAppear {
            updateTxt()
        }
    }
    
    func updateTxt() {
        if let activeApp = NSWorkspace.shared.frontmostApplication {
            let appName = activeApp.localizedName ?? "Unknown"
            //let selfName = "MemoryLens"
            let pid = activeApp.processIdentifier
            let selfPid = getpid()
            let memory = getMemoryFootprint(for: pid)
            let selfMemory = (getMemoryFootprint(for: selfPid))
            let swapUsed = getSwapUsed()
            let swapMB = Double(swapUsed.xsu_used) / 1024.0 / 1024.0 / 1024.0
            memoryInfo = "\(appName)\n\(memory)\nSwapped: \(swapMB)\nself\n\(selfMemory)"
            print("===\nselfMemory:\n\(selfMemory)")
            print(memoryInfo)
        }
    }
    // よりActivityMonitorの表記に近づけるために，getMemoryFootprint()を使用するように変更．
    //    func getMemoryUsage(for pid: pid_t) -> String {
    //        var info = proc_taskinfo()
    //        let size = Int32(MemoryLayout<proc_taskinfo>.size)
    //        let result = proc_pidinfo(pid, PROC_PIDTASKINFO, 0, &info, size)
    //        if result == size {
    //            let memoryMB = Double(info.pti_resident_size) / 1024.0 / 1024.0
    //            if memoryMB < 1024 {
    //                return String(format: ">> %.0f MB", memoryMB)
    //            } else {
    //                let memoryGB = memoryMB / 1024.0
    //                return String(format: ">> %.1f GB", memoryGB)
    //            }
    //        }
    //        return "N/A"
    //    }
    func getMemoryFootprint(for pid: pid_t) -> String {
        var info = rusage_info_v4()
        let result = withUnsafeMutableBytes(of: &info) { bytes in
            proc_pid_rusage(pid, RUSAGE_INFO_V4, bytes.baseAddress?.assumingMemoryBound(to: rusage_info_t?.self))
        }
        if result == 0 {
            let footprintMB = Double(info.ri_phys_footprint) / 1024.0 / 1024.0
            return String(format: "%.1f MB", footprintMB)
        }
        return "N/A"
    }
    
    // スワップ使用量を取得 // 参考文献：https://qiita.com/Kyome/items/01cce674f7c9d9092a14
    func getSwapUsed() -> xsw_usage {
        var query = [CTL_VM, VM_SWAPUSAGE]
        var result = xsw_usage()
        var resultSize = MemoryLayout<xsw_usage>.size
        let r = sysctl(&query, CUnsignedInt(query.count), &result, &resultSize, nil, 0)
        precondition(r == 0)
        precondition(resultSize == MemoryLayout<xsw_usage>.size)
        //print(result)
        return result
    }
}


#Preview{ //TODO Xcode15以降これでいけるらしいが，プレビューとは一体..
    MenuView()
}
