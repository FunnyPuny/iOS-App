// History.swift
// Created by Zlata Guseva on 25.10.2022.

import RealmSwift

class History: Object {
    @Persisted(primaryKey: true) var date: String
    @Persisted var habits: List<ObjectId>

    convenience init(date: String, habits: List<ObjectId>) {
        self.init()
        self.date = date
        self.habits = habits
    }
}
