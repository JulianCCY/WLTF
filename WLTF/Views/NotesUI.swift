//
//  NotesUI.swift
//  WLTF
//
//  Created by iosdev on 20.4.2022.
//

import SwiftUI

struct NotesUI: View {
    
    let note: String
    
    private func img() -> String {
        if (note == "3days") {
            return "Orange note"
        }
        if (note == "1day") {
            return "Red note"
        }
        if (note == "expired") {
           return "Purple note"
        }
        else {
            return ""
        }
    }
    
    var body: some View {
        Image(img())
            .resizable()
            .frame(width: 400, height: 400)
    }
}

struct NotesUI_Previews: PreviewProvider {
    static var previews: some View {
        NotesUI(note: "3days")
    }
}
