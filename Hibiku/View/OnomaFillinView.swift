//
//  OnomaFillinView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import SwiftUI

struct OnomaFillinView: View {
   
    var body: some View {
        TextEditor(text: .constant("どうしてその気持ちになったのか書き出してみよう"))
            .padding(20)
            .foregroundColor(Color(hex: "999999"))
    }
}

#Preview {
    OnomaFillinView()
}
