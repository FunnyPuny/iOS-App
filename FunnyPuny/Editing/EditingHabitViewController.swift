// EditingHabitViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class EditingHabitViewController: ViewController {
    var habit: Habit
    private let selectedFrequencies = List<Frequency>()
    private lazy var editingHabitView = EditingHabitView(habit: habit)
    private lazy var habitManager = HabitManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.editHabit
        view = editingHabitView
    }

    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
