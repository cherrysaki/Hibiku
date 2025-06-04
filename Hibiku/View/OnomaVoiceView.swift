//
//  OnomaVoiceView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/04.
//

import SwiftUI

struct OnomaVoiceView: View {
    @Environment(\.dismiss) var dismiss
    var word: String
    var color: UIColor
    var content: String
    var body: some View {
        VStack{
            
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
        .navigationTitle("「\(word)」と声に出してみよう")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.black)
    }
}

#Preview {
    OnomaVoiceView(word: "わくわく", color: UIColor(hex: "F9D792"), content: "明日は推しのライブがあってわくわくして眠れない！")
}
