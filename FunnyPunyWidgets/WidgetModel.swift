// WidgetModel.swift
// FunnyPuny. Created by Zlata Guseva.

import SwiftUI

struct WidgetModel: Identifiable {
    var id: String = UUID().uuidString
    var taskTitle: String
    var isCompleted: Bool = false
}

class TaskDataModel {
    static let shared = TaskDataModel()

    var tasks: [WidgetModel] = [
        .init(taskTitle: "Record video"),
        .init(taskTitle: "Edit video"),
        .init(taskTitle: "Publish video")
    ]
}
