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
    
//    @State var index: Int = 0
//    @State var category: String = ""
//    @State var items: [Onomatopoeia] = []

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
                            let _ = print(currentPage, index)
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
                                    : Color(hex: "FFFBFB")
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

    func pageView(for index: Int, category: String, items: [Onomatopoeia]) -> some View {
        
        let grouped = Dictionary(grouping: loader.onomatopoeiaList) {
            $0.category
        }

        let categories = grouped.keys.sorted()
        let loopedCategories =
            [categories.last!] + categories + [categories.first!]
        let prevIndex = index == 0 ? 0 : index - 1
        let nextIndex = index == 9 ? 9 : index + 1
        let prevCategory = loopedCategories[prevIndex]
        let nextCategory = loopedCategories[nextIndex]
        let prevColor = Color(hex: (grouped[prevCategory]?.first?.colorHex ?? "CCCCCC"))
        let nextColor = Color(hex: (grouped[nextCategory]?.first?.colorHex ?? "CCCCCC"))
        
        let categoryColor = Color(hex: items.first?.colorHex ?? "FFFBFB")

        return VStack(spacing: 20) {
            ZStack{
                HStack {
                    VStack(alignment: .leading) {
                        Button {
                            self.currentPage = index - 1
                        } label: {
                            Image(systemName: "arrow.left")
                                .tint(Color(hex: "6E6869"))
                        }
                        HStack {
                            Circle()
                                .fill(prevColor)
                                .frame(width: 10, height: 10)
                            Text(prevCategory)
                                .font(.custom("ZenMaruGothic-Regular", size: 15))
                                .foregroundColor(Color(hex: "6E6869"))
                        }
                    }
                    
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Button {
                            self.currentPage = index + 1
                        } label: {
                            Image(systemName: "arrow.right")
                                .tint(Color(hex: "6E6869"))
                        }
                        HStack {
                            Text(nextCategory)
                                .font(.custom("ZenMaruGothic-Regular", size: 15))
                                .foregroundColor(Color(hex: "6E6869"))
                            Circle()
                                .fill(nextColor)
                                .frame(width: 10, height: 10)
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 0) {
                    Circle()
                        .fill(categoryColor)
                        .frame(width: 40, height: 40)
                    
                    Text(category)
                        .font(.custom("ZenMaruGothic-Regular", size: 20))
                        .bold()
                        .foregroundColor(Color(hex: "6E6869"))
                }
                .padding(.top, 30)
            }

            BubbleCategoryView(
                selectedWord: $selectedWord,
                selectedColor: $selectedColor,
                items: items
            )
            Spacer()
        }
        .tag(index)
        .background(Color(hex: "FFF9F9"))
    }

}
