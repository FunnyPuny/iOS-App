// DBManager.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift

// swiftlint:disable all
// TODO:
class DBManager {
    let realm = try! Realm()

    lazy var habits: [Habit] = realm.objects(Habit.self).toArray(type: Habit.self)
    lazy var history: [CompletedHabits] = realm.objects(CompletedHabits.self).toArray(type: CompletedHabits.self)

    init() {}

    func getHabitId(by name: String) -> ObjectId? {
        for habit in habits where habit.name == name {
            return habit.id
        }
        return nil
    }
}
