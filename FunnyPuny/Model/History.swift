// History.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class History: Object {
    @Persisted(primaryKey: true) var date: String
    @Persisted var habits = List<ObjectId>()

    convenience init(date: String) {
        self.init()
        self.date = date
    }
}
