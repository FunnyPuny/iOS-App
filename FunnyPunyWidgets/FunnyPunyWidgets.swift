//
//  FunnyPunyWidgets.swift
//  FunnyPunyWidgets
//
//  Created by Злата Гусева on 03.10.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FPEntry {
        FPEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (FPEntry) -> ()) {
        let entry = FPEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        let timeline = Timeline(entries: [FPEntry()], policy: .atEnd)
        completion(timeline)
    }
}

struct FPEntry: TimelineEntry {
    let date: Date = .now

}

struct FunnyPunyWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {

        }
    }
}

struct FunnyPunyWidgets: Widget {
    let kind: String = "FunnyPunyWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                FunnyPunyWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                FunnyPunyWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("FunnyPuny Widget")
        .description("This is an example of interactive widget.")
    }
}

#Preview(as: .systemSmall) {
    FunnyPunyWidgets()
} timeline: {
    FPEntry()
}
