//
//  OnomaFillinView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import SwiftUI

struct OnomaFillinView: View {
    //画面遷移を管理する変数
    @Binding var selection: Int
    @Binding var showOnomatope: Bool
    @Environment(\.dismiss) var dismiss
    
    @State private var isNextActive = false
    @State private var inputText: String = ""

    var word: String
    var color: UIColor

    var today: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }

    var body: some View {
        NavigationStack {
//            ZStack {
//                Color(hex: "FFFBFB").ignoresSafeArea()

                VStack(spacing: 20) {
                    HStack {
                        Circle()
                            .foregroundColor(Color(color))
                            .frame(width: 40, height: 40)
                        Text(word)
                            .font(.custom("ZenMaruGothic-Regular", size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 25)

                    PlaceholderTextEditor(text: $inputText, placeholder: "どうして \(word) するのか書いてみよう")

                    Button {
                        if !inputText.isEmpty {
                            isNextActive = true
                        }
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(inputText.isEmpty ? Color(hex: "999999") : Color(hex: "FEA9AF"))
                            .frame(width: 70, height: 70)
                    }
                    
                    Spacer(minLength: 50)

                    NavigationLink(
                        destination: OnomaVoiceView(showOnomatope: $showOnomatope, selection: $selection, word: word, color: color, content: inputText),
                        isActive: $isNextActive
                    ) {
                        EmptyView()
                    }
                }
                .padding(.top, 20)
//            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(today)
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
    }
}
struct PlaceholderTextEditor: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .padding(.horizontal, 8)
                .background(Color.clear)

            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(hex: "999999"))
                    .font(.custom("ZenMaruGothic-Regular", size: 15))
                    .padding(.top, 12)
                    .padding(.horizontal, 12)
                    .opacity(0.85)
            }
        }
        .frame(height: 400)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 25)
    }
}

