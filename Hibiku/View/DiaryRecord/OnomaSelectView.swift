//
//  Onomatope.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI

struct OnomaSelectView: View {

    //オノマトペを読み込む
    @ObservedObject var loader: OnomaLoader

    //画面遷移を管理する変数
    @Binding var showOnomatope: Bool
    @Binding var selection: Int
    @Environment(\.dismiss) var dismiss

    @State private var selectedWord: String? = nil
    @State private var selectedColor: UIColor? = nil

    let pages = Array(0..<8)
    @State private var currentPage = 1
    @State private var isNextActive = false

    var body: some View {

        let grouped = Dictionary(grouping: loader.onomatopoeiaList) {
            $0.category
        }

        let categories = grouped.keys.sorted()
        let loopedCategories =
            [categories.last!] + categories + [categories.first!]

        NavigationStack {
            ZStack {
                Color(hex: "FFF9F9").ignoresSafeArea()

                VStack(spacing: 0) {
                    TabView(selection: $currentPage) {
                        ForEach(0..<loopedCategories.count, id: \.self) {
                            index in
                            let category = loopedCategories[index]
                            let items = grouped[category] ?? []
                            pageView(
                                for: index,
                                category: category,
                                items: items
                            )
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    Button {
                        isNextActive = true
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundColor(
                                (selectedWord != nil && selectedColor != nil)
                                    ? Color(hex: "FEA9AF")
                                    : Color(hex: "999999")
                            )
                           
                    }
                    .disabled(selectedWord == nil || selectedColor == nil)

                    Spacer(minLength: 70)
                }
                NavigationLink(
                    destination: Group {
                        if let word = selectedWord, let color = selectedColor {
                            OnomaFillinView(
                                selection: $selection,
                                showOnomatope: $showOnomatope,
                                word: word,
                                color: color
                            )
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

    func pageView(for index: Int, category: String, items: [Onomatopoeia], grouped: [String: [Onomatopoeia]],
                  loopedCategories: [String]) -> some View {
        
        
        // カテゴリ配列とグループはViewの外で定義済み
        let prevIndex = index - 1
        let nextIndex = index + 1

        // ループ対応なので必ずsafe
        let prevCategory = loopedCategories[prevIndex]
        let nextCategory = loopedCategories[nextIndex]
        let prevColor = Color(hex: (grouped[prevCategory]?.first?.colorHex ?? "CCCCCC"))
        let nextColor = Color(hex: (grouped[nextCategory]?.first?.colorHex ?? "CCCCCC"))
        
        let categoryColor = Color(hex: items.first?.colorHex ?? "FFFBFB")

        return VStack(spacing: 20) {
            HStack {

                VStack {
                    Button {
                        self.currentPage = index - 1
                    } label: {
                        Image(systemName: "arrow.left")
                            .tint(Color(hex: "6E6869"))
                            .padding(20)
                    }
                    HStack {
                        Circle()
//                            .fill(prevColor)
                            .frame(width: 10, height: 10)
//                        Text(prevCategory)
//                            .font(.custom("ZenMaruGothic-Regular", size: 20))
//                            .foregroundColor(Color(hex: "6E6869"))
                    }
                }

                Spacer()

                VStack(spacing: 0) {
                    Circle()
                        .fill(categoryColor)
                        .frame(width: 40, height: 40)
                        .padding(.top, 30)
                    Text(category)
                        .font(.custom("ZenMaruGothic-Regular", size: 20))
                        .bold()
                        .foregroundColor(Color(hex: "6E6869"))
                }

                Spacer()

                VStack {
                    Button {
                        self.currentPage = index + 1
                    } label: {
                        Image(systemName: "arrow.right")
                            .tint(Color(hex: "6E6869"))
                            .padding(20)
                    }
                    HStack {
                        Circle()
//                            .fill(nextColor)
                            .frame(width: 10, height: 10)
//                        Text(nextCategory)
//                            .font(.custom("ZenMaruGothic-Regular", size: 20))
//                            .foregroundColor(Color(hex: "6E6869"))
                    }
                }
            }
            BubbleCategoryView(
                selectedWord: $selectedWord,
                selectedColor: $selectedColor,
                items: items
            )
            Spacer()
        }
        .tag(index)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "FFF9F9"))
    }

}
