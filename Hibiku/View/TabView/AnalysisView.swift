//
//  Analysis.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI
import SwiftData

struct AnalysisView: View {
    @Query(sort: \Diary.date, order: .reverse) var entries: [Diary]
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "M.d"
        return df
    }
    
    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    @State private var shift: Bool = false
    
    var body: some View {
        
        let grouped = Dictionary(grouping: entries) {
            Calendar.current.startOfDay(for: $0.date)
        }.sorted { $0.key > $1.key }
        
        NavigationStack {
            ZStack(alignment: .topLeading){
                if entries.isEmpty {
                    VStack {
                        Spacer()
                        Text("表示するデータがありません")
                            .font(.custom("ZenMaruGothic-Regular", size: 32))
                            .foregroundColor(Color(hex: "6E6869"))
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                }
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(entries, id: \.id) { entry in
                            VStack(spacing: 0) {
                                WaveView(waveform: entry.wavePath,
                                         color: Color(hex: entry.onomaColorHex))
                                
                                .offset(x: shift ? -2 : 2)
                                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: shift)
                                .onAppear {
                                    shift = true
                                }
                                
                                
                                Text(dateFormatter.string(from: entry.date))
                                    .font(.custom("ZenMaruGothic-Regular", size: 15))
                                    .foregroundColor(Color(hex: "6E6869"))
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 3)
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                            }
                        }
                        
                    }
                }
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .black, location: 0.1),
                            .init(color: .black, location: 0.9),
                            .init(color: .clear, location: 1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                Text("\(String(format: "%d",currentYear))")
                    .font(.custom("ZenMaruGothic-Bold", size: 32))
                    .foregroundColor(Color(hex: "6E6869"))
                    .padding(.leading, 32)
                    .padding(.top, 20)
            }
            .background(Color(hex: "FFFBFB"))
            .navigationTitle("分析")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
}

struct WaveView: View {
    let waveform: [Float]
    let color: Color
    @State private var fill: CGFloat = 0.0
    
    var body: some View {
        WaveformShape(waveform: waveform)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [color.opacity(0.6), color]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(height: CGFloat(waveform.count) * 5) // 例：1要素あたり4ptの高さ
        
    }
}


struct WaveformShape: Shape {
    let waveform: [Float]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        guard !waveform.isEmpty else { return path }
        
        let spacing = rect.height / CGFloat(waveform.count)
        let centerX = rect.midX
        
        for (index, value) in waveform.enumerated() {
            let y = CGFloat(index) * spacing
            let barWidth = CGFloat(value) * rect.width * 0.8// 0〜1想定
            let x = centerX - barWidth / 2
            let barRect = CGRect(x: x, y: y, width: barWidth, height: spacing * 0.3)
            path.addRect(barRect)
        }
        
        return path
    }
}


#Preview {
    AnalysisView()
}
