//
//  WaveformView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/05.
//

import SwiftUI

struct WaveformView: View {
    
    @ObservedObject var audioManager: AudioRecorderManager
    
    var body: some View {
     GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let data = audioManager.amplitudes
            let visibleCount = Int(width / 3)
            let dataSuffix = Array(data.suffix(visibleCount))

         HStack(spacing: 2) {
             ForEach(dataSuffix.indices, id: \.self) { i in
                 let value = dataSuffix[i]
                 Rectangle()
                     .fill(Color(hex: "6E6869"))
                     .frame(width: 2, height: CGFloat(value) * height)
             }
         }
         .frame(minWidth: width, maxWidth: .infinity, alignment: .trailing)

        }

    }

}
