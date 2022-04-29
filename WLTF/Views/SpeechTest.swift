//
//  SpeechTest.swift
//  WLTF
//
//  Created by Chan Chung Yin on 29/4/2022.
//

import SwiftUI
import Foundation

struct SpeechTest: View {
    
    @State private var recording = false
    @ObservedObject private var mic = MicMonitor(numberOfSamples: 30)
    private var speechManager = SpeechManager()
    
    var body: some View {
        NavigationView {
            Button(action: addItem) {
                Image(systemName: recording ? "stop.fill" : "mic.fill")
                    .font(.system(size: 40))
                    .padding()
                    .cornerRadius(10)
            }
            .foregroundColor(.red)
        }.onAppear{
            speechManager.checkPermissions()
        }
        
    }
     
    private func addItem() {
        if speechManager.isRecording {
            self.recording = false
            mic.stopMonitoring()
            speechManager.stopRecording()
        } else {
            self.recording = true
            mic.startMonitoring()
            speechManager.start{ (speechText) in
                guard let text = speechText, !text.isEmpty else {
                    self.recording = false
                    return
                }
                
                print(text)
            }
        }
        speechManager.isRecording.toggle()
    }
}

struct SpeechTest_Previews: PreviewProvider {
    static var previews: some View {
        SpeechTest()
    }
}

