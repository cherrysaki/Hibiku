//
//  OnomaVoiceView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/04.
//

import AVFoundation
import SwiftUI

enum RecordingState {
    case idle, recording, finished
}

struct OnomaVoiceView: View {
    @StateObject var manager = AudioRecorderManager()
    @Environment(\.dismiss) var dismiss
    var word: String
    var color: UIColor
    var content: String

    @State private var recordingState: RecordingState = .idle

    var body: some View {
        VStack {
            Spacer(minLength: 400)
            WaveformView(audioManager: manager)
                .frame(height: 100)
            Button {
                switch recordingState {
                case .idle:
                    manager.startRecording()
                    recordingState = .recording
                case .recording:
                    manager.stopRecording()
                    recordingState = .finished
                case .finished:
                    // 遷移処理や保存など
                    print("チェック済み！")
                }
            } label: {
                Image(systemName: iconName(for: recordingState))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(hex: "FEA9AF"))
            }
            .frame(width: 70, height: 70)
            
            Spacer(minLength: 70)
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
    // 状態ごとに表示するアイコン
    private func iconName(for state: RecordingState) -> String {
        switch state {
        case .idle:
            return "mic.circle.fill"
        case .recording:
            return "pause.circle.fill"
        case .finished:
            return "checkmark.circle.fill"
        }
    }
}

#Preview {
    OnomaVoiceView(
        word: "わくわく",
        color: UIColor(hex: "F9D792"),
        content: "明日は推しのライブがあってわくわくして眠れない！"
    )
}
