// ToggleStateIntent.swift
// FunnyPuny. Created by Zlata Guseva.

import AppIntents
import SwiftUI

struct ToggleStateIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Task State"

    /// Parametrs

    @Parameter(title: "Task ID")
    var id: String

    init() {}

    init(id: String) {
        self.id = id
    }

    func perform() async throws -> some IntentResult {
        // update data base
        if let index = TaskDataModel.shared.tasks.firstIndex(where: { $0.id == id }) {
            TaskDataModel.shared.tasks[index].isCompleted.toggle()
            print("Updated")
        }
        return .result()
    }
}
