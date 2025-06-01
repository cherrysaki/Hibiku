//
//  ContentView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    @State private var showOnomatope = false
    @StateObject var loader = OnomaLoader()
    
    var body: some View {
        TabView(selection: $selection) {
            CalendarView()   // Viewファイル①
                .tabItem {
                    Image(systemName: "calendar")
                }
                .tag(1)
            
            // 真ん中のタブ：押すと遷移
            Color.clear
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                }
                .tag(2)
            
            AnalysisView()  // Viewファイル③
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
        
        
    } // body
    
}
#Preview {
    
}
