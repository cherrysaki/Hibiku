//
//  AudioRecorderManager.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/05.
//

import AVFoundation
import Combine

class AudioRecorderManager: NSObject, ObservableObject {
    private var recorder: AVAudioRecorder!
    private var timer: Timer?
    
    @Published var amplitudes: [Float] = []  // 波形データ

    func startRecording() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session 設定エラー: \(error.localizedDescription)")
        }
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]

        let url = FileManager.default.temporaryDirectory.appendingPathComponent("record.m4a")

        do {
            recorder = try AVAudioRecorder(url: url, settings: settings)
            recorder.isMeteringEnabled = true
            recorder.prepareToRecord()
            recorder.record()
            startMetering()
        } catch {
            print("録音失敗: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        recorder?.stop()
        timer?.invalidate()
        timer = nil
    }

    private func startMetering() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.recorder.updateMeters()
            let power = self.recorder.averagePower(forChannel: 0)
            let normalized = self.normalizePowerLevel(power)
            DispatchQueue.main.async {
                self.amplitudes.append(normalized)
            }
        }
    }

    private func normalizePowerLevel(_ power: Float) -> Float {
        let minDb: Float = -80
        if power < minDb {
            return 0
        } else {
            return pow((abs(minDb) + power) / abs(minDb), 2)
        }
    }
}
