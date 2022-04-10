//
//  TimeController.swift
//  WLTF
//
//  Created by Chan Chung Yin on 9/4/2022.
//

import Foundation

func calcExpiry(date: Date) -> String {
    let minutes = Int(date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if days <= 0 && hours <= 0 {
        return "Expired"
    } else if hours <= 24 {
        return "\(hours) hour(s) left"
    } else {
        return "\(days) day(s) left"
    }
}
