//
//  EditHabitView.swift
//  HabitTracker
//
//  Created by Blake McAnally on 1/14/21.
//

import SwiftUI

struct EditHabitView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject
    var tracker: HabitTracker
    
    let habit: Habit
    
    @State
    var name: String
    
    @State
    var details: String
    
    @State
    var count: Int
    
    private var isButtonEnabled: Bool {
        name != "" && details != ""
    }
    
    init(tracker: HabitTracker, habit: Habit) {
        self.tracker = tracker
        self.habit = habit
        self._name = State(initialValue: habit.name)
        self._details = State(initialValue: habit.details)
        self._count = State(initialValue: habit.count)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Details", text: $details)
                Stepper(value: $count) {
                    Text("Completions: \(count)")
                }
            }
            Section {
                Button("Reset") {
                    name = habit.name
                    details = habit.details
                    count = habit.count
                }
                Button("Save") {
                    guard isButtonEnabled else { return }
                    tracker.update(
                        id: habit.id,
                        name: name,
                        details: details,
                        count: count
                    )
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }.navigationTitle("Edit Habit")
    }
}

