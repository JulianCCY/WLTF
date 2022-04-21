//
//  TImeController.swift
//  WLTF
//
//  Created by Chan Chung Yin on 11/4/2022.
//

import Foundation

//This func can calculate how many days left until the expiry date

func calcExpiryText(date: Date) -> String {
    let minutes = Int(date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    // if expired
    if days <= 0 && hours <= 0 { return "Expired" }
    // if less 24 hours
    else if hours <= 24 { return "\(hours) hour(s) left" }
    // if more than a day
    else { return "\(days) day(s) left" }
}

func calcExpiryColor(date: Date) -> String {
    let minutes = Int(date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    // if expired
    if days <= 0 && hours <= 0 { return "expired" }
    // if less 24 hours
    else if hours <= 24 { return "1day" }
    // if more than 3 days
    else if days <= 3 { return "3days" }
    // more than 3 days
    else { return "normal" }
}

// format the entry date
func formatting(currentDate: Date) -> String {
    let date = currentDate
    let formattedDate = date.getFormattedDate(format: "EEEE, MMM d, yyyy") // Set output format
    return formattedDate
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

func checkExpired(expiryDate: Date) -> Bool {
    let minutes = Int(expiryDate.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    return days <= 0 && hours <= 0 ? true : false
}
