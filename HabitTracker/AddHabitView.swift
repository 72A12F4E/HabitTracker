//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Blake McAnally on 1/14/21.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @ObservedObject
    var tracker: HabitTracker
    
    @State
    var name: String = ""
    
    @State
    var details: String = ""
    
    private var isButtonEnabled: Bool {
        name != "" && details != ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Details", text: $details)
                }
                Section {
                    Button("Save") {
                        guard isButtonEnabled else { return }
                        tracker.addHabit(name: name, details: details)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }.navigationTitle("Add Habit")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
