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
        Button(action: {}) {
            Image(systemName: recording ? "stop.fill" : "mic.fill")
                .font(.system(size: 40))
                .padding()
                .cornerRadius(10)
        }
        .foregroundColor(.red)
    }
}

struct SpeechTest_Previews: PreviewProvider {
    static var previews: some View {
        SpeechTest()
    }
}

