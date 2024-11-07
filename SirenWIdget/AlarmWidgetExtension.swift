//
//  AlarmWidgetExtension.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/5/24.
//

import SwiftUI
import WidgetKit

@main
struct AlarmWidgetExtension: Widget {

    let kind: String = "AlarmWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: AlarmProvider(),
            content: {
                AlarmView(entry: $0)
            }
        )
        .configurationDisplayName("Sound the alarm")
        .description("Quickly sound an alarm")
        .supportedFamilies([
            .accessoryRectangular,
            .accessoryInline,
            .accessoryCircular
        ])
    }
}

#Preview(as: .accessoryRectangular) {
    AlarmWidgetExtension()
} timeline: {
    AlarmEntry(date: Date(), message: "Sound the alarm!")
}

