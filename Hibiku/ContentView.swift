//
//  ContentView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // タブの選択項目を保持する
    @State var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            CalendarView()   // Viewファイル①
                .tabItem {
                    Image(systemName: "calendar")
                }
                .tag(1)
            
            OnomatopeView()   // Viewファイル②
                .tabItem {
                    Image(systemName:"plus.circle.fill")
                }
                .tag(2)
            
            AnalysisView()  // Viewファイル③
                .tabItem {
                    Image(systemName:"waveform.path")
                }
                .tag(3)
            
        }
        .tint(Color(red: 254/255, green: 169/255, blue: 175/255))

    } // body
    
}
#Preview {
    
}
