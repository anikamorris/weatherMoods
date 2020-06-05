//
//  DateLayer.swift
//  weatherMoods
//
//  Created by Anika Morris on 6/4/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class Day: Codable {
    private let date = Date()
    private let calendar = Calendar.current
    private let currentDay: Int
    
    init() {
        self.currentDay = calendar.component(.day, from: date)
    }
    
    func getDate() -> String {
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return "\(month)/\(day)/\(year)"
    }
    
    func getDay() -> Int {
        let day = calendar.component(.day, from: date)
        return day
    }
}
