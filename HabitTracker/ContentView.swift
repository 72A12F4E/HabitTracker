//
//  ContentView.swift
//  HabitTracker
//
//  Created by Blake McAnally on 1/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    var tracker = HabitTracker()
    
    @State
    private var isShowingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tracker.habits) { habit in
                    NavigationLink(destination: EditHabitView(tracker: tracker, habit: habit)) {
                        HabitRow(habit: habit)
                    }
                }.onDelete(perform: { offsets in
                    tracker.delete(at: offsets)
                })
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Habit Tracker")
            .navigationBarItems(trailing: Button(action: {
                isShowingAddHabit = true
            }, label: {
                Label("Add Habit", image: "plus")
            }))
        }.sheet(isPresented: self.$isShowingAddHabit) {
            AddHabitView(tracker: tracker)
        }
    }
}

struct HabitRow: View {
    let habit: Habit
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.headline)
                Text(habit.details)
            }
            Spacer()
            Text("\(habit.count)")
        }
    }
}

