// History.swift
// Created by Zlata Guseva on 25.10.2022.

import RealmSwift
import UIKit

class History: Object {
    @Persisted(primaryKey: true) var date: String = Date().string(dateFormat: .formatyyMMdd)
    @Persisted var habits = List<ObjectId>()

    convenience init(date: String, habits: List<ObjectId>) {
        self.init()
        self.date = date
        self.habits = habits
    }
}
