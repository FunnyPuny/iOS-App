// ProfileCellType.swift
// FunnyPuny. Created by Zlata Guseva.

enum ProfileCellType: CaseIterable {
    case notifications
    case appearance
    case achievments
    case donation

    var name: String {
        switch self {
        case .notifications: return Texts.notifications
        case .appearance: return Texts.appearance
        case .achievments: return Texts.achievments
        case .donation: return Texts.donation
        }
    }

    var isAvailable: Bool {
        switch self {
        case .notifications: return true
        default: return false
        }
    }
}
