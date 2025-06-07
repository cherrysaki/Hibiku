//
//  ContentView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//
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
        ZStack {
            TabView(selection: $selection) {
                OnomaCalendarView(diary: diary)
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                    .tag(1)
                
                Color.clear
                    .tabItem {
                        // 中央はダミータブ
                        Text("")
                    }
                    .tag(2)
                
                AnalysisView()
                    .tabItem {
                        Image(systemName: "waveform.path")
                    }
                    .tag(3)
            }
            .tint(Color(hex: "FEA9AF"))
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // カレンダーアイコン
                    Button(action: {
                        selection = 1
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(selection == 1 ? Color(hex: "FEA9AF"): .gray)
                    }
                    
                    Spacer()
                    Button(action: {
                        showOnomatope = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.white, Color(hex: "FEA9AF"))
                            .frame(width: 60, height: 60)
                    }
                    .offset(y: -20)
                    
                    Spacer()
                    
                    Button(action: {
                        selection = 3
                    }) {
                        Image(systemName: "waveform.path")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(selection == 3 ? Color(hex: "FEA9AF") : .gray)
                    }
                    
                    Spacer()
                }
                .padding(.top, 8)
                .frame(height: 60)
                .background(Color.white)
                .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: -1)
            }
        }
        .fullScreenCover(isPresented: $showOnomatope) {
            OnomaSelectView(loader: loader, showOnomatope: $showOnomatope, selection: $selection)
        }
    }
}

