//
//  Speech .swift
//  WLTF
//
//  Created by Chan Chung Yin on 30/4/2022.
//

import Foundation
import AVFoundation
import NaturalLanguage
import CoreML

// This controller is to get what did the user say, and then do the response

class NLPController {
    
    // perform a low level speech analytics
    // try to understand what does the speech means
    func speechAnalytics(userSpeech: String) {
        let recommendationKeywords = ["What can", "What should", "recommend", "recommendation", "idea", "suggest", "suggestion", "any", "anything", "advice"]
        let checkIfICanCookKeywords = ["Can I cook", "Can I", "Do you think", "Do I", "make", "cook"]
//        let WLTF = "what's left the fridge"
//        let greet = "how are you"
        
        // early return if users said unrelated sentence
        guard recommendationKeywords.contains(where: {userSpeech.contains($0)})
                || checkIfICanCookKeywords.contains(where: {userSpeech.contains($0)}) else {
            speechResponse(message: "Sorry, I don't understand, could you try again?")
            return
        }
        
        // we need to know if the user speech contains some keywords and find the meaning similarity
        // NLP word embedding: calculate the similarity between two sentence
        if recommendationSimilarity(text: userSpeech) <= 0.95 && recommendationKeywords.contains(where: {userSpeech.contains($0)}) {
            //What do you recommend to cook?
            // What can I cook?
            // What should I cook?
            // Do you have any suggestion
            // Do you have any advice on what I should cook?
            speechResponse(message: DataController().dishRecommendation())
        }
        
        
        
        // check if user has enough ingredient to cook something
        // I wanna let user to ask more than one dish
        if checkCanICookSimilarity(text: userSpeech) <= 1.3 && checkIfICanCookKeywords.contains(where: {userSpeech.contains($0)}) {
            // ask can I cook something
            // e.g can I cook an egg?
            
            var dishName = [String]()
            
            let model = try! NLModel(contentsOf: Bundle.main.url(forResource: "foodTag", withExtension: "mlmodelc")!)
            let tagger = NLTagger(tagSchemes: [.nameType])
            
            tagger.setModels([model], forTagScheme: .nameType)
            tagger.string = userSpeech
            
            tagger.enumerateTags(in: userSpeech.startIndex..<userSpeech.endIndex, unit: .word, scheme: .nameType, options: .omitWhitespace) { tag, tokenRange in
                if tag!.rawValue == "FOOD" && ["ingredients", "ingredient"].contains(userSpeech[tokenRange].lowercased()) == false{
                    dishName.append("\(userSpeech[tokenRange])")
                }
                return true
            }
            
            DataController().checkCookable(dish: dishName.joined(separator: " ").lowercased())
        }
    }
    
    
    // output depends on what did the user say
    private func speechResponse(message: String) {
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
        }catch{
            print(error)
        }
        
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: message)
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.5
        utterance.volume = 0.8
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
        
        do {
            disableAVSession()
        }
    }
    
    // end the AVSession so the speech and response will work
    private func disableAVSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't disable.")
        }
    }
    
    private func recommendationSimilarity(text: String) -> Double {
        var similarity = 0.0
        if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english) {
            let distance = sentenceEmbedding.distance(between: text, and: "What do you recommend to cook?")
            similarity = Double(distance.description)!
//            print(similarity)
        }
        return similarity
    }
    
    private func checkCanICookSimilarity(text: String) -> Double {
        var similarity = 0.0
        if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english) {
            let distance = sentenceEmbedding.distance(between: text, and: "Do I have enough ingredient to cook?")
            similarity = Double(distance.description)!
            print(similarity)
        }
        return similarity
    }
    
}
