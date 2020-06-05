//
//  MoodHistory.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/5/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct MoodHistory: Codable {
    var mood: Mood
    let date: Day
    let icon: String
}
