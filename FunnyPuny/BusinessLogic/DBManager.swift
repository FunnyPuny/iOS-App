// DBManager.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift

// swiftlint:disable all
// TODO:
class DBManager {
    private let realm = try! Realm()

    lazy var habits: [Habit] = realm.objects(Habit.self).toArray(type: Habit.self)
    lazy var history: [History] = realm.objects(History.self).toArray(type: History.self)

    init() {}
}
