//
//  Calendar.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI
import SwiftUICalendar

struct OnomaCalendarView: View {
    
    @StateObject var calendarController = CalendarController()
    @State private var selectedDate: YearMonthDay? = nil
    @State private var isShowingDiaryList = false
    
    
    let diary: [Diary]
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 12){
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("\(String(format: "%d", calendarController.yearMonth.year))")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        Text("\(calendarController.yearMonth.month)")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal, 32)
                
                VStack(spacing: 12) {
                    HStack(spacing: 0) {
                        ForEach(["月","火","水","木","金","土","日"], id: \.self) { day in
                            Text(day)
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    CalendarView(calendarController) { date in
                        GeometryReader { geometry in
                            VStack(spacing: 10) {
                                Text("\(date.day)")
                                    .frame(alignment: .center)
                                    .font(.system(size: 10, weight: .light, design: .default))
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.3)
                                
                                if let color = colorFor(date: date) {
                                    Button {
                                        selectedDate = date
                                        isShowingDiaryList = true
                                    } label: {
                                        Circle()
                                            .fill(color)
                                            .frame(width: 25, height: 25)
                                    }
                                    .buttonStyle(.plain)
                                } else {
                                    Spacer().frame(height: 25) // 丸がないときの高さ合わせ
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    .frame(height: 400)
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 24)
                
                Spacer()
                
                NavigationLink(
                    destination: CalendarDetailView(date: selectedDate?.date, diary: diary),
                    isActive: $isShowingDiaryList
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("カレンダー")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(hex: "FFFBFB"))
            
        }
    }
    
    func colorFor(date: YearMonthDay) -> Color? {
        guard let targetDate = date.date else { return nil }
        // 同じ日付の日記を抽出
        let entries = diary.filter {
            Calendar.current.isDate($0.date, inSameDayAs: targetDate)
        }
        
        guard !entries.isEmpty else { return nil }
        
        // RGB値の合計
        var totalR: CGFloat = 0
        var totalG: CGFloat = 0
        var totalB: CGFloat = 0
        var count: CGFloat = 0
        
        for entry in entries {
            let uiColor = UIColor(hex: entry.onomaColorHex)
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            if uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                totalR += r
                totalG += g
                totalB += b
                count += 1
            }
        }
        
        guard count > 0 else { return nil }
        
        //同じ日に書いた複数日記のオノマトペの色の平均値を返すことにする
        let avgColor = UIColor(red: totalR / count, green: totalG / count, blue: totalB / count, alpha: 1.0)
        return Color(avgColor)
    }
    
}
