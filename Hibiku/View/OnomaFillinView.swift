//
//  OnomaFillinView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import SwiftUI

struct OnomaFillinView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isNextActive = false
    @State var inputText: String = ""

    var word: String
    var color: UIColor
    var today: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }

    var body: some View {
        
        let _ = print(word)
        
        VStack{
            Spacer(minLength: 30)
            HStack{
                Spacer(minLength: 25)
                Circle()
                    .foregroundColor(Color(color))
                    .frame(width: 40,height: 40,alignment: .leading)
                
                Text(word)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            PlaceholderTextEditor(text: $inputText,placeholder: "どうして \(word)するのか書いてみよう")
                .padding(20)
            
            NavigationLink(destination: OnomaVoiceView(word: word, color: color, content: inputText), isActive: $isNextActive) {
                EmptyView()
            }
            .hidden()

            Button {
                if inputText != "" {
                    isNextActive = true
                }
            } label: {
                Image(systemName: "arrow.forward.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(
                        (inputText != "")
                        ? Color(hex: "FEA9AF")
                        : Color(hex: "999999")
                    )
            }
            .frame(width: 70, height: 70)

        }
        .navigationBarBackButtonHidden(true)
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
        .navigationTitle(today)
        .navigationBarTitleDisplayMode(.inline)
        .tint(.black)

    }
}

#Preview {
    OnomaFillinView(word: "わくわく", color: UIColor(hex: "F9D792"))
}

struct PlaceholderTextEditor: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(hex: "999999"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }

            TextEditor(text: $text)
                .padding(4)
                .background(Color.clear)
        }
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
    }
}

