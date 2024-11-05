//
//  AlarmWidget.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/5/24.
//

import WidgetKit
import Foundation
import SwiftUI

struct AlarmEntry: TimelineEntry {
    let date: Date
    let message: String
}

struct AlarmProvider: TimelineProvider {
    
    private let placeholderEntry = AlarmEntry(
        date: Date(),
        message: "Sound the alarm"
    )
    
    func placeholder(in context: Context) -> AlarmEntry {
        return placeholderEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AlarmEntry) -> Void) {
        completion(placeholderEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AlarmEntry>) -> Void) {
        let entries : [AlarmEntry] = [AlarmEntry(date: Date(), message: "Sound the alarm")]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct AlarmView : View {
    var entry: AlarmProvider.Entry
    
    var body: some View {
        VStack(spacing: 0) {
            Image("siren-no-background")
                .resizable()
                .scaledToFit()
            Text("Sound the alarm!")
        }
        .containerBackground(for: .widget) {
            RadialGradient(colors: [.white, .blue], center: .center, startRadius: 1.0, endRadius: 100.0)
        }
    }
}
