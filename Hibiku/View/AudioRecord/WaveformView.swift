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
            let step = max(1, data.count / Int(width))

            HStack(spacing: 1) {
                ForEach(data.indices.filter { $0 % step == 0 }, id: \.self) { index in
                    let value = data[index]
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 2, height: CGFloat(value) * height)
                }
            }
        }
    }
}
