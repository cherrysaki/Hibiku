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
    
    let pages = Array(0..<8)
    @State private var currentPage = 1
    
    var body: some View {
        let grouped = Dictionary(grouping: loader.onomatopoeiaList) { $0.category }
        let loopedPages = [pages.last!] + pages + [pages.first!]
        
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    TabView(selection: $currentPage) {
                        ForEach(0..<loopedPages.count, id: \.self) { index in
                            Text("ページ: \(loopedPages[index])")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .edgesIgnoringSafeArea(.bottom)
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
        .onChange(of: currentPage) { newValue in
            if newValue == 0 {
                DispatchQueue.main.async {
                    currentPage = pages.count
                }
            } else if newValue == loopedPages.count - 1 {
                DispatchQueue.main.async {
                    currentPage = 1
                }
            }
        }
    }
}

#Preview {
    OnomaSelectView(loader: OnomaLoader())
}
