//
//  SpeechManager.swift
//  WLTF
//
//  Created by Chan Chung Yin on 29/4/2022.
//

import Foundation
import Speech
import SwiftUI

class SpeechController {
    
    public var isRecording = false
    
    private var audioEngine = AVAudioEngine()
    private var inputNote: AVAudioInputNode!
    private var audioSession: AVAudioSession!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    // get the permission from the user
    func speechRecognitionAuthorization() {
        SFSpeechRecognizer.requestAuthorization{ (authStatus) in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("User accepted")
                case .notDetermined:
                    print("Speech recognition is not available at this stage")
                case .denied:
                    print("User rejected the permission")
                case .restricted:
                    print("User restricted the permission for speech recognition")
                default:
                    print("Speech recognition is not available")
                }
            }
        }
    }
    
    // try to listeh user's voice
    func listen(completion: @escaping (String?) -> Void) {
        if isRecording {
            stopRecording()
        } else {
            startRecording(completion: completion)
        }
    }
    
    // try to record user's voice
    func startRecording(completion: @escaping (String?) -> Void) {
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable else {
            print("Speech recognition is not available")
            return
        }
        
        //create the speech recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true
        
        if recognizer.supportsOnDeviceRecognition {
            recognitionRequest?.requiresOnDeviceRecognition = true
        }
        
        recognizer.recognitionTask(with: recognitionRequest!) { (result, error) in
            guard error == nil else {
                print("error \(error!.localizedDescription)")
                return
            }
            guard let result = result else { return }
            
            if result.isFinal {
                DispatchQueue.main.async {
                    completion(result.bestTranscription.formattedString)
                }
            }
        }
        
        // retrieve the microphone input
        audioEngine = AVAudioEngine()
        inputNote = audioEngine.inputNode
        
        // Configure the microphone input
        let recordingFormat = inputNote.outputFormat(forBus: 0)
        inputNote.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .spokenAudio, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try audioEngine.start()
        } catch {
            print(error)
        }
        
    }
    
    // stop recording user's voice
    func stopRecording() {
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        audioEngine.stop()
        inputNote.removeTap(onBus: 0)
        
        try? audioSession.setActive(false)
        audioSession = nil
    }
    
}
