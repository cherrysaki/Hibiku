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
                            
                            VStack(spacing: 20) {
                                Text(category)
                                    .font(.title)
                                    .bold()
                                    .padding(.top, 40)
                                BubbleCategoryView(items: items)
                                
                                Spacer()
                            }
                            .tag(index)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
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
                    currentPage = categories.count
                }
            } else if newValue == loopedCategories.count - 1 {
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

struct BubbleCategoryView: UIViewControllerRepresentable {
    let items: [Onomatopoeia]

    func makeUIViewController(context: Context) -> BubbleViewController {
        let vc = BubbleViewController()
        vc.onomatopoeiaList = items
        return vc
    }

    func updateUIViewController(_ uiViewController: BubbleViewController, context: Context) {
        // 更新の必要があればここに書く
    }
}
