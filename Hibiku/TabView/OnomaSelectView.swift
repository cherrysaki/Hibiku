//
//  Onomatope.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI

struct OnomaSelectView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var loader: OnomaLoader
    
    // 表示するページの中身（今はダミーで Int ）
    let pages = Array(0..<5)
    // 現在表示しているページ（初期値 = 実ページ1）
    @State private var currentPage = 1
    
    var body: some View {
        let grouped = Dictionary(grouping: loader.onomatopoeiaList) { $0.category }
        
        // ダミーページ含む配列
        let loopedPages = [pages.last!] + pages + [pages.first!]
        
        NavigationStack {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<loopedPages.count, id: \.self) { index in
                        Text("ページ: \(loopedPages[index])")
                            .frame(width: UIScreen.main.bounds.width - 45, height: 300)
                            .background(Color.cyan)
                            .cornerRadius(15)
                            .padding(20)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never)) // ページドット（お好みで）
                .onChange(of: currentPage) { newValue in
                    if newValue == 0 {
                        // 左端のダミー → 最後の本物へジャンプ
                        DispatchQueue.main.async {
                            currentPage = pages.count
                        }
                    } else if newValue == loopedPages.count - 1 {
                        // 右端のダミー → 最初の本物へジャンプ
                        DispatchQueue.main.async {
                            currentPage = 1
                        }
                    }
                }
            }
            .navigationTitle("今の気持ちを選ぼう")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                }
            }
            
        }
    }
}
    
    #Preview {
        OnomaSelectView(loader: OnomaLoader())
    }
