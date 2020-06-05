//
//  PersistenceLayer.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct PersistenceLayer {
    
    private(set) var day: Day? = nil
    private(set) var moods: [Mood] = []
    private(set) var moodJournal: [MoodHistory] = []
    private static let userDefaultsMoodsKeyValue = "MOODS_ARRAY"
    private static let userDefaultsMoodJournalKeyValue = "MOOD_HISTORY_ARRAY"
    private static let userDefaultsDayKeyValue = "DAY"

    init() {
        self.loadMoods()
        self.loadMoodJournal()
        self.setDay()
    }
    
    private mutating func setDay() {
        let today = Day()
        self.day = today
        guard let dayData = try? JSONEncoder().encode(self.day) else {
            fatalError("could not encode list of moods")
        }

        let userDefaults = UserDefaults.standard
        userDefaults.set(dayData, forKey: PersistenceLayer.userDefaultsDayKeyValue)
        userDefaults.synchronize()        
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
    
    private mutating func loadMoodJournal() {
       let userDefaults = UserDefaults.standard
       guard
           let moodJournalData = userDefaults.data(forKey: PersistenceLayer.userDefaultsMoodJournalKeyValue),
           let moods = try? JSONDecoder().decode([MoodHistory].self, from: moodJournalData) else {
               return
       }
       self.moodJournal = moods
    }
    
    @discardableResult
    mutating func newMoodHistory(mood: String, day: Day, icon: String) -> MoodHistory {
        let newMood = Mood(mood: mood)
        let newMoodHistory = MoodHistory(mood: newMood, date: day, icon: icon)
        self.moodJournal.insert(newMoodHistory, at: 0)
        self.saveMoodJournal()
        return newMoodHistory
    }
    
    private func saveMoodJournal() {
        guard let moodsData = try? JSONEncoder().encode(self.moodJournal) else {
            fatalError("could not encode list of moods")
        }

        let userDefaults = UserDefaults.standard
        userDefaults.set(moodsData, forKey: PersistenceLayer.userDefaultsMoodJournalKeyValue)
        userDefaults.synchronize()
    }
    
    mutating func setNeedsToReloadMoodJournal() {
        self.loadMoodJournal()
    }
    
    mutating func updateMoodHistory(_ moodIndex: Int, newMood: String) {
        self.moodJournal[moodIndex].mood.mood = newMood
        self.saveMoodJournal()
    }
    
    mutating func deleteMoodHistory(_ moodIndex: Int) {
        self.moodJournal.remove(at: moodIndex)
        self.saveMoodJournal()
    }
}
