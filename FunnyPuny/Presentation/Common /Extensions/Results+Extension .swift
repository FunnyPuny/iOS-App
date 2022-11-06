// Results+Extension .swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift

extension Results {
    func toArray<T>(type _: T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}
