//
//  k.swift
//  MemoryLens
//
//  Created by matt-u on 2025/08/17.
//

import Foundation
import AppKit

class PermissionChecker {
    
    // 権限チェック（他プロセスの情報が取得できるか確認）
    static func checkMemoryAccessPermission() -> Bool {
        // Finderなど、常に存在するプロセスでテスト
        let testPIDs = [
            1,     // launchd（システムプロセス）
            getppid() // 親プロセス
        ]
        
        for pid in testPIDs {
            var rusageInfo = rusage_info_v4()
            let result = withUnsafeMutableBytes(of: &rusageInfo) { bytes in
                proc_pid_rusage(pid, RUSAGE_INFO_V4, bytes.baseAddress?.assumingMemoryBound(to: rusage_info_t?.self))
            }
            
            // 一つでも成功すれば権限ありと判断
            if result == 0 && rusageInfo.ri_phys_footprint > 0 {
                return true
            }
        }
        
        return false
    }
    
    // 初回起動時のチェックと案内
    static func requestPermissionIfNeeded() {
        // 初回起動チェック（UserDefaultsを使用） >> 権限ないと主機能が使えないのでとりあえず，毎回聞く形に．
        // let hasCheckedPermission = UserDefaults.standard.bool(forKey: "HasCheckedMemoryPermission")
        //if !hasCheckedPermission
        //{
        UserDefaults.standard.set(true, forKey: "HasCheckedMemoryPermission")
        //print(checkMemoryAccessPermission())
        if !checkMemoryAccessPermission() {
            //showPermissionDialog()  // フルディスクアクセス関係なかったので，コメントアウト
        }
        //}
    }
    
    // 権限設定の案内ダイアログ
    static func showPermissionDialog() {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "メモリ情報へのアクセス権限"
            alert.informativeText = """
            他のアプリケーションのメモリ使用量を正確に表示するには、追加の権限が必要です。
            
            設定方法：
            1. システム設定 > プライバシーとセキュリティ を開く
            2.「フルディスクアクセス」を選択
            3. このアプリを追加して有効化
            
            ※この設定は任意です。設定しない場合、他プロセスのメモリ消費量を取得できません。
            """
            alert.alertStyle = .informational
            alert.addButton(withTitle: "フルディスクアクセスを開く")
            alert.addButton(withTitle: "後で")
            
//            // ウィンドウの幅を調整
//            alert.window.setFrame(NSRect(x: 0, y: 0, width: 250, height: 300), display: true)
//            // アクセサリービューで幅を固定
//            let dummyView = NSView(frame: NSRect(x: 0, y: 0, width: 250, height: 0))
//            alert.accessoryView = dummyView
            
            let response = alert.runModal()
            
            if response == .alertFirstButtonReturn {
                // システム設定を開く
                openSystemPreferences()
            }
        }
    }
    
    // システム設定を開く
    static func openSystemPreferences() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"){
            NSWorkspace.shared.open(url)
        }
        
//        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_DeveloperTools") {
//            NSWorkspace.shared.open(url)
//        } else {
//            // フォールバック：一般的なプライバシー設定を開く
//            if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy") {
//                NSWorkspace.shared.open(url)
//            }
//        }
    }
}
