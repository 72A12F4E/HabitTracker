//
//  HabitTracker.swift
//  HabitTracker
//
//  Created by Blake McAnally on 1/14/21.
//

import UIKit

struct Habit: Identifiable, Codable {
    var id: UUID
    var name: String
    var details: String
    var count: Int
}

class HabitTracker: ObservableObject {
    
    @Published
    private(set) var habits: [Habit]
    
    init() {
        habits = []
        load()
    }
    
    func habit(id: UUID) -> Habit? {
        habits.first(where: { $0.id == id })
    }
    
    func addHabit(name: String, details: String) {
        habits.append(
            Habit(
                id: UUID(),
                name: name,
                details: details,
                count: 0
            )
        )
        sync()
    }
    
    func update(
        id: UUID,
        name: String? = nil,
        details: String? = nil,
        count: Int? = nil
    ) {
        guard let index = habits.firstIndex(where: { $0.id == id }) else {
            return
        }
        if let newName = name {
            habits[index].name = newName
        }
        if let newDetails = details {
            habits[index].details = newDetails
        }
        if let newCount = count {
            habits[index].count = newCount
        }
        sync()
    }
    
    func delete(at offset: IndexSet) {
        habits.remove(atOffsets: offset)
        print(habits)
        sync()
    }
    
    func delete(id: UUID) {
        guard let index = habits.firstIndex(where: { $0.id == id }) else {
            return
        }
        habits.remove(at: index)
        sync()
    }
    
    // MARK: Persistance Layer
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "habits"
    
    func sync() {
        save()
        load()
    }
    
    func save() {
        do {
            let data = try encoder.encode(habits)
            defaults.set(data, forKey: defaultsKey)
        } catch {
            print(error)
        }
    }
    
    func load() {
        do {
            if let data = defaults.data(forKey: defaultsKey) {
                habits = try decoder.decode([Habit].self, from: data)
            } else {
                habits = []
            }
        } catch {
            print(error)
        }
    }
}
