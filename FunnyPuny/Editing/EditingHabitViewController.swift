// EditingHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class EditingHabitViewController: ViewController {
    var habitName: String
    private let selectedFrequencies = List<Frequency>()
    private lazy var editingHabitView = EditingHabitView(name: habitName)
    private lazy var habitManager = HabitManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.editHabit
        view = editingHabitView
    }

    init(habitName: String) {
        self.habitName = habitName
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
