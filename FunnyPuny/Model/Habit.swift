// Habit.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class Habit: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var frequency: List<Frequency>
    @Persisted var createdDate = Date()

    convenience init(name: String, frequency: List<Frequency>, createdDate: Date) {
        self.init()
        self.name = name
        self.frequency = frequency
        self.createdDate = createdDate
    }
}
