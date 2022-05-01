//
//  LanguageController.swift
//  WLTF
//
//  Created by iosdev on 1.5.2022.
//
// This is the LanguageController file, a localizationService for localization :)
// Switching languages

import Foundation

//class LocalizationService {
//
//    static let shared = LocalizationService()
//    static let changedLanguage = Notification.Name("changedLanguage")
//
//    private init() {}
//    
//    var language: languages {
//        get {
//            guard let languageString = UserDefaults.standard.string(forKey: "language") else {
//                return .english
//            }
//            return languages(rawValue: languageString) ?? .english
//        } set {
//            if newValue != language {
//                UserDefaults.standard.setValue(newValue.rawValue, forKey: "language")
//                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
//            }
//        }
//    }
//}
