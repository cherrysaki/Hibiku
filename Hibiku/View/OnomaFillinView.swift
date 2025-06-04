//
//  OnomaFillinView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import SwiftUI

struct OnomaFillinView: View {
    var word: String
    var color: UIColor
    
    var body: some View {
        let _ = print(word)
        Text("選択されたワード: \(word)")
        .foregroundColor(Color(color))
        TextEditor(text: .constant("どうしてその気持ちになったのか書き出してみよう"))
            .padding(20)
            .foregroundColor(Color(hex: "999999"))
    }
}

#Preview {
    OnomaFillinView(word: "わくわく", color: UIColor(hex: "F9D792"))
}
