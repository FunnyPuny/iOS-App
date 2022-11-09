// Habit.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class Habit: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var note: String = ""
    @Persisted var frequency: List<Day>
    @Persisted var createdDate = Date()

    convenience init(name: String, note: String, frequency: List<Day>) {
        self.init()
        self.name = name
        self.note = note
        self.frequency = frequency
    }
}
