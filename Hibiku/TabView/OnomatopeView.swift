//
//  Onomatope.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/30.
//

import SwiftUI

struct OnomatopeView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            NavigationStack{
                VStack {
                }
                .navigationTitle("今の気持ちを選ぼう")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black) 
                }
                                    
                )
                
            }
            Text("Page2")
        }
        
    }
}

#Preview {
    OnomatopeView()
}
