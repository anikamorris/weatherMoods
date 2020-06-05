//
//  PersistenceLayer.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct PersistenceLayer {
    
    private(set) var moods: [Mood] = []
    private static let userDefaultsMoodsKeyValue = "MOODS_ARRAY"

    init() {
        self.loadMoods()
    }
    
    private mutating func loadMoods() {
       let userDefaults = UserDefaults.standard
       guard
           let moodData = userDefaults.data(forKey: PersistenceLayer.userDefaultsMoodsKeyValue),
           let moods = try? JSONDecoder().decode([Mood].self, from: moodData) else {
               return
       }
       self.moods = moods
    }
    
    @discardableResult
    mutating func newMood(mood: String) -> Mood {
        let newMood = Mood(mood: mood)
        self.moods.insert(newMood, at: 0) // Prepend the mood to the array
        self.saveMoods()
        return newMood
    }
    
    private func saveMoods() {
        guard let moodsData = try? JSONEncoder().encode(self.moods) else {
            fatalError("could not encode list of moods")
        }

        let userDefaults = UserDefaults.standard
        userDefaults.set(moodsData, forKey: PersistenceLayer.userDefaultsMoodsKeyValue)
        userDefaults.synchronize()
    }
    
    mutating func setNeedsToReloadMoods() {
        self.loadMoods()
    }
    
    mutating func updateMood(_ moodIndex: Int, newMood: String) {
        self.moods[moodIndex].mood = newMood
        self.saveMoods()
    }
    
    mutating func delete(_ moodIndex: Int) {
        self.moods.remove(at: moodIndex)
        self.saveMoods()
    }
}
