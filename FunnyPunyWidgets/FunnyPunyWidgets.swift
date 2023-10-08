// FunnyPunyWidgets.swift
// FunnyPuny. Created by Zlata Guseva.

import AVFoundation
import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FPEntry {
        FPEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
    }

    func getSnapshot(in context: Context, completion: @escaping (FPEntry) -> Void) {
        let entry = FPEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let latestTask = Array(TaskDataModel.shared.tasks.prefix(3))
        let latestEntries = [FPEntry(lastThreeTasks: latestTask)]
        let timeline = Timeline(entries: latestEntries, policy: .atEnd)
        completion(timeline)
    }
}

struct FPEntry: TimelineEntry {
    let date: Date = .now

    var lastThreeTasks: [WidgetModel]
}

struct FunnyPunyWidgetsEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Tasks")
                .fontWeight(.semibold)
                .padding(.bottom, 10)

            VStack(alignment: .leading, spacing: 6) {
                if entry.lastThreeTasks.isEmpty {
                    Text("No tasks for today")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    /// sorting completed to last
                    ForEach(entry.lastThreeTasks.sorted {
                        !$0.isCompleted && $1.isCompleted
                    }) { task in
                        HStack(spacing: 6) {
                            Button(intent: ToggleStateIntent(id: task.id)) {
                                Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                                    .foregroundColor(Color(UIColor(named: "backgroundAccent") ?? .blue))
                            }
                            .buttonStyle(.plain)

                            VStack(alignment: .leading, spacing: 0) {
                                Text(task.taskTitle)
                                    .textScale(.secondary)
                                    .lineLimit(1)
                                    .strikethrough(task.isCompleted, pattern: .solid, color: .primary)

                                // Divider()
                            }
                        }

                        if task.id != entry.lastThreeTasks.last?.id {
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
        .containerBackground(.fill.tertiary, for: .widget)
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
    FPEntry(lastThreeTasks: TaskDataModel.shared.tasks)
}
