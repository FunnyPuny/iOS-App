// Habit.swift
// Created by Zlata Guseva on 14.10.2022.

import RealmSwift

class Habit: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var note: String = ""
    @Persisted var frequency: List<Day>
    @Persisted var isDone = false

    convenience init(name: String, note: String, frequency: List<Day>) {
        self.init()
        self.name = name
        self.note = note
        self.frequency = frequency
    }
}
