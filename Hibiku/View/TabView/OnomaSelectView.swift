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
    
    @State private var selectedWord: String? = nil
    @State private var selectedColor: UIColor? = nil

    let pages = Array(0..<8)
    @State private var currentPage = 1
    @State private var isNextActive = false
    
    var body: some View {
        
        let grouped = Dictionary(grouping: loader.onomatopoeiaList) { $0.category }
        
        let categories = grouped.keys.sorted()
        let loopedCategories = [categories.last! ] + categories + [categories.first!]
        
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    TabView(selection: $currentPage) {
                        ForEach(0..<loopedCategories.count, id: \.self) { index in
                            let category = loopedCategories[index]
                            let items = grouped[category] ?? []
                            pageView(for: index, category: category, items: items)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    Button {
                        isNextActive = true
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(
                                (selectedWord != nil && selectedColor != nil)
                                ? Color(hex: "FEA9AF")
                                : Color(hex: "999999")
                            )
                    }
                    .frame(width: 70, height: 70)
                    .disabled(selectedWord == nil || selectedColor == nil)

                    Spacer(minLength: 70)
                }
                NavigationLink(
                    destination: Group {
                        if let word = selectedWord, let color = selectedColor {
                            OnomaFillinView(word: word, color: color)
                        } else {
                            Text("値が未選択です")
                        }
                    },
                    isActive: $isNextActive
                ) {
                    EmptyView()
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
                            .tint(.black)
                    }
                }
            }
        }
        .onChange(of: currentPage) { newValue in
            if newValue == 0 {
                DispatchQueue.main.async {
                    currentPage = categories.count
                }
            } else if newValue == loopedCategories.count - 1 {
                DispatchQueue.main.async {
                    currentPage = 1
                }
            }
        }
    }
    
    func pageView(for index: Int, category: String, items: [Onomatopoeia]) -> some View {
        VStack(spacing: 20) {
            Text(category)
                .font(.title)
                .bold()
                .padding(.top, 40)
            BubbleCategoryView(selectedWord: $selectedWord, selectedColor: $selectedColor,items: items)
            Spacer()
        }
        .tag(index)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    OnomaSelectView(loader: OnomaLoader())
}


