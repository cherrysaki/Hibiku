//
//  OnomaDetailView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/07.
//
//


import SwiftUI
import SwiftData

struct CalendarDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    let date: Date?
    let diary: [Diary]
    
    @State private var entryToDelete: Diary? = nil // ← 削除対象の一時保持
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date ?? Date())
    }
    
    var body: some View {
        ZStack {
            Color(hex: "FFFBFB").ignoresSafeArea()
            
            let entries = diary.filter {
                if let date = date {
                    return Calendar.current.isDate($0.date, inSameDayAs: date)
                }
                return false
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(entries, id: \.id) { entry in
                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack(alignment: .center, spacing: 8) {
                                Circle()
                                    .fill(Color(hex: entry.onomaColorHex))
                                    .frame(width: 40, height: 40)
                                
                                Text(entry.onomaWord)
                                    .font(.custom("ZenMaruGothic-Regular", size: 15))
                                    .foregroundColor(Color(hex: "6E6869"))
                                Spacer()
                                Button {
                                    entryToDelete = entry // ← アラート用に記録
                                } label: {
                                    Image(systemName: "trash")
                                        .tint(Color(hex: "6E6869"))
                                }
                            }
                            
                            Text(entry.content)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.custom("ZenMaruGothic-Regular", size: 15))
                                .foregroundColor(Color(hex: "6E6869"))
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                        .padding(.horizontal, 25)
                        .transition(.opacity.combined(with: .scale))
                    }
                    .animation(.easeInOut(duration: 0.3), value: entries)
                }
                .padding(.top, 16)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("\(formattedDate)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .tint(.black)
                    }
                }
            }
            .alert(item: $entryToDelete) { entry in
                Alert(
                    title: Text("本当に削除しますか？"),
                    message: Text("この記録は元に戻せません。"),
                    primaryButton: .destructive(Text("削除")) {
                        withAnimation {
                            context.delete(entry)
                            try? context.save()
                            dismiss()
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

