//
//  ContentView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var diary: [Diary]
    
    @State var selection = 1
    @State private var showOnomatope = false
    @StateObject var loader = OnomaLoader()
    
    var body: some View {
        TabView(selection: $selection) {
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
                .tag(1)
            
            Color.clear
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                }
                .tag(2)
            
            AnalysisView()
                .tabItem {
                    Image(systemName:"waveform.path")
                }
                .tag(3)
            
        }
        .onChange(of: selection) { newValue in
            if newValue == 2 {
                showOnomatope = true
                selection = 1 // 戻す
            }
        }
        .fullScreenCover(isPresented: $showOnomatope) {
            OnomaSelectView(loader: loader)
        }
        .tint(Color(hex: "FEA9AF"))
        
        
    }
    
}
#Preview {
    
}
