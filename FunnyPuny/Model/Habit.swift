// Habit.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class Habit: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var frequency: List<Frequency>
    @Persisted var createdDate = Date()
    @Persisted var reminderTime: String?
    @Persisted var reminderNote: String?

    convenience init(name: String, frequency: List<Frequency>) {
        self.init()
        self.name = name
        self.frequency = frequency
    }
}
