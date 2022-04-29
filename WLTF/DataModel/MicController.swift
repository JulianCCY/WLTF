//
//  MicManager.swift
//  WLTF
//
//  Created by Chan Chung Yin on 29/4/2022.
//

import Foundation
import AVFoundation

class MicController: ObservableObject {
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?

    private var currentSample: Int
    private let numberOfSamples: Int

    @Published public var soundSamples: [Float]

    init(numberOfSamples: Int) {
        self.numberOfSamples = numberOfSamples > 0 ? numberOfSamples : 10
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0

        let audioSesstion = AVAudioSession.sharedInstance()
        if audioSesstion.recordPermission != .granted {
            audioSesstion.requestRecordPermission { (success) in
                if !success {
                    fatalError("We need audio recording")
                }
            }
        }

        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSetting: [String: Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSetting)
            try audioSesstion.setCategory(.playAndRecord, mode: .default, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func startMonitoring() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(timer) in
            self.audioRecorder.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
    }
    
    public func stopMonitoring() {
        audioRecorder.stop()
        
    }
    
    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}
