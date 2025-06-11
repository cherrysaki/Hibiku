//
//  OnomaVoiceView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/04.
//

import AVFoundation
import SwiftUI
import SwiftData

enum RecordingState {
    case idle, recording, finished
}

struct OnomaVoiceView: View {
    
    //SwiftDataの使用
    @Environment(\.modelContext) private var context
    @Query private var diary: [Diary]
    
    //音声入力の使用
    @StateObject var manager = AudioRecorderManager()
    @State private var recordingState: RecordingState = .idle
    
    //画面遷移を管理する変数
    @Binding var showOnomatope: Bool
    @Binding var selection: Int
    @Environment(\.dismiss) var dismiss
    
    //保存ボタンを押したときに出るアラートの管理
    @State var showAlert = false
    @State var alertMessage = ""

    var word: String
    var color: UIColor
    var content: String

    var body: some View {
        VStack {
            Spacer(minLength: 400)
            WaveformView(audioManager: manager)
                .frame(height: 100)
            Spacer()
            Button {
                switch recordingState {
                case .idle:
                    manager.startRecording()
                    recordingState = .recording
                case .recording:
                    manager.stopRecording()
                    recordingState = .finished
                case .finished:
                    add(onomaWord: word, onomaColor: color, content: content, wavePath: manager.amplitudes)
                    selection = 1  //OnomaCalendarViewへ戻る
                    showOnomatope = false
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("「\(word)」と声に出してみよう")
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
        .background(Color(hex: "FFFBFB"))
    }
    
    // データの追加と更新
    private func add(onomaWord: String, onomaColor: UIColor, content: String, wavePath: [Float]) {
        let newRecording = Diary(
            onomaWord: word,
            onomaColor: color,
            content: content,
            wavePath: manager.amplitudes
        )
        print(newRecording)
        context.insert(newRecording)
        do {
            try context.save()
            print(wavePath)
            alertMessage = "保存に成功しました！"
        } catch {
            alertMessage = "保存に成功しました！"
        }
        showAlert = true
    }
    

    // 表示するアイコンの切り替わり
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

