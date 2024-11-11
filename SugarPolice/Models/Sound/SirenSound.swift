//
//  SirenSound.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/11/24.
//

import Foundation

enum SirenSound: CaseIterable {
    
    case siren
    case euSiren
    case warAlarm
    case warningBuzzer
    
    var label: String {
        switch self {
        case .siren:
            "siren"
        case .euSiren:
            "siren2"
        case .warAlarm:
            "alert"
        case .warningBuzzer:
            "warning"
        }
    }
    
    var path: String? {
        Bundle.main.path(forResource: "/Sounds/\(label)", ofType: "mp3")
    }
    
    var icon: String {
        switch self {
        case .siren:
            "🚓"
        case .euSiren:
            "🚨"
        case .warAlarm:
            "☢️"
        case .warningBuzzer:
            "☣️"
        }
    }
}
