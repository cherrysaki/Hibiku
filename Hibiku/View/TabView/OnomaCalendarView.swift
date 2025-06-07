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
                            CalendarDateCellView(
                                date: date,
                                color: colorFor(date: date),
                                onTap: {
                                    selectedDate = date
                                    isShowingDiaryList = true
                                }
                            )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    
                    .frame(height: 400)
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 25)
                
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
        return diary.averageColor(for: targetDate)
    }
    
}

struct CalendarDateCellView: View {
    let date: YearMonthDay
    let color: Color?
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(date.day)")
                .font(.system(size: 10, weight: .light))
                .opacity(date.isFocusYearMonth == true ? 1 : 0.3)
            
            if let color = color {
                Button(action: onTap) {
                    Circle()
                        .fill(color)
                        .frame(width: 25, height: 25)
                }
                .buttonStyle(.plain)
            } else {
                Spacer().frame(height: 25)
            }
        }
    }
}
