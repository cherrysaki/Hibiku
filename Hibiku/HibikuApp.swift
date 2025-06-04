//
//  HibikuApp.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI
import SwiftData

@main
struct HibikuApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Diary.self)
        }
    }
}
